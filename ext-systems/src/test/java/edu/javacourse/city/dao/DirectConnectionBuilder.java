package edu.javacourse.city.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DirectConnectionBuilder implements ConnectionBuilder {
    @Override
    public Connection getConnection() throws SQLException {
        String connectionUrl = "jdbc:sqlserver://localhost:1433;" +
                "databaseName=city-register;" +
                "user=sa;" +
                "password=nub;";
        // TODO change password
        return DriverManager.getConnection(connectionUrl);
    }
}
