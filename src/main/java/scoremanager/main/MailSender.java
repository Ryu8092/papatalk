//アカウント登録
package scoremanager.main;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class MailSender {

    public static void sendVerificationCode(
            String toEmail, String code) throws Exception {

        String fromEmail = "ryuichiro0704@gmail.com";
        String appPassword = "mlgd irdb mjxo ogmd";

        if (fromEmail == null || appPassword == null
                || fromEmail.isBlank() || appPassword.isBlank()) {
            throw new IllegalStateException(
                    "Gmailの環境変数が設定されていません。");
        }

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(
            props,
            new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(
                        fromEmail, appPassword);
                }
            }
        );

        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(fromEmail));
        message.setRecipient(
            Message.RecipientType.TO,
            new InternetAddress(toEmail));
        message.setSubject(
            "認証コードのお知らせ", "UTF-8");
        message.setText(
            "認証コードは " + code
            + " です。\n有効期限内に画面へ入力してください。",
            "UTF-8");

        Transport.send(message);
    }
}
