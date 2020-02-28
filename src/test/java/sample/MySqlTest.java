package sample;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class MySqlTest {
	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://192.168.0.7:2008/stock?serverTimezone=UTC";
	private static final String USER = "stock_read";
	private static final String PW = "dev@!read";

	@Test
	public void testConnect() throws Exception {

		Class.forName(DRIVER);

		try (Connection con = DriverManager.getConnection(URL, USER, PW)) {
			System.out.println(con);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
