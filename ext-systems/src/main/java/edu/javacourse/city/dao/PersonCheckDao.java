package edu.javacourse.city.dao;

import edu.javacourse.city.domain.PersonRequest;
import edu.javacourse.city.domain.PersonResponse;
import edu.javacourse.city.exception.PersonCheckException;

import java.sql.*;

public class PersonCheckDao {
    private static final String SQL_REQUEST =
            "SELECT temporal FROM cr_address_person ap " +
                    "INNER JOIN cr_person p ON p.person_id = ap.person_id " +
                    "INNER JOIN cr_address a ON a.address_id = ap.address_id " +
                    "WHERE " +
                    "CURRENT_TIMESTAMP >= ap.start_date AND (CURRENT_TIMESTAMP <= ap.end_date OR ap.end_date IS NULL)" +
                    "AND UPPER(p.sur_name) = UPPER(?) " +
                    "AND UPPER(p.given_name ) = UPPER(?) " +
                    "AND UPPER(patronymic) = UPPER(?) " +
                    "AND p.date_of_birth = ? " +
                    "AND a.street_code = ? " +
                    "AND UPPER(a.building) = UPPER(?) ";

    private ConnectionBuilder connectionBuilder;

    public void setConnectionBuilder(ConnectionBuilder connectionBuilder) {
        this.connectionBuilder = connectionBuilder;
    }

//    public PersonCheckDao() {
//        try {
//            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }

    private Connection getConnection() throws SQLException {
//        String connectionUrl = "jdbc:sqlserver://localhost:1433;" +
//                "databaseName=city-register;" +
//                "user=sa;" +
//                "password=nub;";
//        // TODO change password
//        return DriverManager.getConnection(connectionUrl);
        return connectionBuilder.getConnection();
    }

    public PersonResponse checkPerson(PersonRequest request) throws PersonCheckException {
        PersonResponse response = new PersonResponse();

        String sql = SQL_REQUEST;
        if (request.getExtension() != null) {
            sql += "and upper(a.extension) = upper(?) ";
        } else {
            sql += "and extension is null ";
        }
        if (request.getApartment() != null) {
            sql += "and upper(a.apartment) = upper(?) ";
        } else {
            sql += "and a.apartment is null ";
        }

        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            int count = 1;
            stmt.setString(count++, request.getSurName());
            stmt.setString(count++, request.getGivenName());
            stmt.setString(count++, request.getPatronymic());
            stmt.setDate(count++, java.sql.Date.valueOf(request.getDateOfBirth()));
            stmt.setInt(count++, request.getStreetCode());
            stmt.setString(count++, request.getBuilding());
            if (request.getExtension() != null) {
                stmt.setString(count++, request.getExtension());
            }
            if (request.getApartment() != null) {
                stmt.setString(count++, request.getApartment());
            }

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                response.setRegistered(true);
                response.setTemporal(rs.getBoolean("temporal"));
            }
        } catch (SQLException ex) {
            throw new PersonCheckException();
            //ex.printStackTrace();
        }

        return response;
    }
}
