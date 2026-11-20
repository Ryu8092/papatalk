package scoremanager.main;
 
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import bean.Event;
import bean.EventImage;
import dao.EventDAO;
import dao.EventImageDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import tool.Action;
 
public class EventOrganizerRegistrationAction extends Action {
 
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
 
        req.setCharacterEncoding("UTF-8");
        
     // イベント画像を取得
        List<Part> imageParts = new ArrayList<>();

        for (Part part : req.getParts()) {
            if ("images".equals(part.getName()) && part.getSize() > 0) {
                imageParts.add(part);
            }
        }

        // 画像枚数のチェック
        if (imageParts.size() < 1 || imageParts.size() > 6) {
            req.setAttribute("message", "画像は1〜6枚選択してください。");
            req.getRequestDispatcher(
                "/scoremanager/main/event_organizer_registration.jsp"
            ).forward(req, res);
            return;
        }

        // 画像の保存先
        String uploadDirectory =
            "C:\\work\\pleiades\\2023-12\\workspace\\papatalk\\src\\main\\webapp\\uploads";

        Path uploadPath = Path.of(uploadDirectory);

        // フォルダが存在しない場合は作成
        Files.createDirectories(uploadPath);

        // 保存した画像URLを格納
        List<String> imageUrls = new ArrayList<>();

        // 画像を1枚ずつ処理
        for (Part imagePart : imageParts) {

            // ファイルサイズのチェック（5MBまで）
            if (imagePart.getSize() > 5 * 1024 * 1024) {
                req.setAttribute("message", "画像は5MB以内にしてください。");
                req.getRequestDispatcher(
                    "/scoremanager/main/event_organizer_registration.jsp"
                ).forward(req, res);
                return;
            }

            // 画像形式のチェック
            String contentType = imagePart.getContentType();
            String extension;

            if ("image/jpeg".equals(contentType)) {
                extension = ".jpg";
            } else if ("image/png".equals(contentType)) {
                extension = ".png";
            } else if ("image/gif".equals(contentType)) {
                extension = ".gif";
            } else {
                req.setAttribute("message",
                    "JPEG・PNG・GIF形式の画像を選択してください。");
                req.getRequestDispatcher(
                    "/scoremanager/main/event_organizer_registration.jsp"
                ).forward(req, res);
                return;
            }

            // 実際に画像として読み込めるか確認
            try (InputStream input = imagePart.getInputStream()) {
                if (ImageIO.read(input) == null) {
                    req.setAttribute("message",
                        "正しい画像ファイルを選択してください。");
                    req.getRequestDispatcher(
                        "/scoremanager/main/event_organizer_registration.jsp"
                    ).forward(req, res);
                    return;
                }
            }

            // 保存するファイル名
            String fileName = UUID.randomUUID().toString() + extension;

            // 保存先
            Path savedImagePath = uploadPath.resolve(fileName);

            // 画像を保存
            try (InputStream input = imagePart.getInputStream()) {
                Files.copy(input, savedImagePath);
            }

            // DBに保存する画像URL
            String imageUrl = "/uploads/" + fileName;

            imageUrls.add(imageUrl);

        }
 
        Event bean = new Event();
 
        bean.setTitle(req.getParameter("title"));
 
        String eventDate = req.getParameter("event_date");

        LocalDateTime dateTime = LocalDateTime.parse(eventDate);

        bean.setEvent_date(Timestamp.valueOf(dateTime));
 
        bean.setDeadline(Date.valueOf(req.getParameter("deadline")));
 
        bean.setCapacity(Integer.parseInt(req.getParameter("capacity")));
 
        bean.setEvent_place(req.getParameter("event_place"));
 
        bean.setEvent_details(req.getParameter("event_details"));
 

        bean.setEvent_url("");
 
        EventDAO dao = new EventDAO();

	     // イベントを登録してイベントIDを取得
	     int eventId = dao.insert(bean);
	
	     // 画像をDBに登録
	     EventImageDAO imageDao = new EventImageDAO();
	
	     for (int i = 0; i < imageUrls.size(); i++) {
	
	         EventImage image = new EventImage();
	
	         image.setEvent_id(eventId);
	         image.setUrl(imageUrls.get(i));
	         image.setDisplay_order(i + 1);
	
	         imageDao.insert(image);
	     }
	
	     // 完了画面へ
	     req.getRequestDispatcher(
	         "/scoremanager/main/OrganizerCompleteDisplay.action"
	     ).forward(req, res);
    }
}