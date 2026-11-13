	package bean;
	 
	import java.io.Serializable;
	 
	public class ExpectedParticipants implements Serializable {
	 
	    private int user_id;
	    private int event_id;
	    private int adultnumber;
	    private int childnumber;
	 
	    public int getUser_id() {
	        return user_id;
	    }
	 
	    public void setUser_id(int user_id) {
	        this.user_id = user_id;
	    }
	 
	    public int getEvent_id() {
	        return event_id;
	    }
	 
	    public void setEvent_id(int event_id) {
	        this.event_id = event_id;
	    }
	 
	    public int getAdultnumber() {
	        return adultnumber;
	    }
	 
	    public void setAdultnumber(int adultnumber) {
	        this.adultnumber = adultnumber;
	    }
	 
	    public int getChildnumber() {
	        return childnumber;
	    }
	 
	    public void setChildnumber(int childnumber) {
	        this.childnumber = childnumber;
	    }
	}