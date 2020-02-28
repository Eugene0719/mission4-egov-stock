package sample;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class OracleTest {
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1522:orcl2";
	private static final String USER = "system";
	private static final String PW = "1q2w3e";

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
