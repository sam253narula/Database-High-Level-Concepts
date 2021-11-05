package com.example;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class PostgreSQLJDBC {
	private static final int MAX_RETRIES = 2;

	public static void main(String args[]) throws ClassNotFoundException {
		Connection conn = null;
		Statement stmt = null;
		int retries = MAX_RETRIES;
		do {
			try {
				Class.forName("org.postgresql.Driver");
				conn = DriverManager.getConnection("jdbc:postgresql://localhost:5433/dvdrental", "postgres",
						"password");
				System.out.println("Opened database successfully");
				stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("select * from language;");
				while (rs.next()) {
					int id = rs.getInt("language_id");
					String name = rs.getString("name");
					Date last_update = rs.getDate("last_update");
					System.out.println("ID = " + id);
					System.out.println("NAME = " + name);
					System.out.println("LAST_UPDATE = " + last_update);
					System.out.println();
				}
				rs.close();
				stmt.close();
				break;
			} catch (Exception e) {
				e.printStackTrace();
				System.err.println(e.getClass().getName() + ": " + e.getMessage());
				System.exit(0);
			}

		} while (retries > 0);
	}
}