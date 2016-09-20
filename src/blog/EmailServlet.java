/** EmailServlet
 * Handles the cron job requests for our app-engine blog application.
 * Every day at 5pm CentralTime, service emails a  digest of any new posts 
 * in the last 24 hours to all subscribed users.
 * If there are no new posts, no email is sent. 
 */
package blog;

import java.io.IOException;
import java.util.Properties;
import java.util.logging.Logger;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class EmailServlet extends HttpServlet {

	private static final Logger _logger = Logger.getLogger(EmailServlet.class.getName());

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			_logger.info("Cron Job GET has been executed");

			Properties props = new Properties();
			Session session = Session.getDefaultInstance(props, null);

			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress("ronny@blog-143315.appspotmail.com", "Awesome Blog Admin"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress("ronnymacmaster@gmail.com", "Mr. User"));
			msg.setSubject("Awesome Blog Email Digest");
			Transport.send(msg);

			// job goes here
		} catch (Exception e) {
			// Log any exceptions in your Cron Job
		}
	}

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			_logger.info("Cron Job POST has been executed");
			// job goes here
		} catch (Exception e) {
			// Log any exceptions in your Cron Job
		}
	}
}
