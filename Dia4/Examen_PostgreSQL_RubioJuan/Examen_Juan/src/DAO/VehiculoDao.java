package DAO;

import Model.Vehiculo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Connection.PostgresDataSource;  

public class VehiculoDao {
    
    public List<Vehiculo> listarVehiculosDisponibles() throws SQLException {
        List<Vehiculo> vehiculos = new ArrayList<>();
        String query = "SELECT id, marca, modelo, anio, precio, estado FROM vehiculo WHERE estado IN ('nuevo', 'usado')";

        try (Connection con = new PostgresDataSource().getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Vehiculo vehiculo = new Vehiculo(
                        rs.getInt("id"),
                        rs.getString("marca"),
                        rs.getString("modelo"),
                        rs.getInt("anio"),
                        rs.getDouble("precio"),
                        rs.getString("estado")
                );
                vehiculos.add(vehiculo);
            }
        }

        return vehiculos;
    }
}