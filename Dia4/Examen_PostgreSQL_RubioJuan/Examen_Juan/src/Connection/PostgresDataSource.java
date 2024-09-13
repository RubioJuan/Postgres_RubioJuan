/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Connection;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import javax.swing.JOptionPane;

/**
 *
 * @author Juan Felipe Rubio
 */
public class PostgresDataSource {
     private Connection con;

    public Connection getConnection() {
        Properties props = new Properties();
        try (InputStream input = getClass().getClassLoader().getResourceAsStream("Connection/DataBaseConfig.properties")) {
            if (input == null) {
                throw new IllegalStateException("Archivo DataBaseConfig.properties no encontrado");
            }

            props.load(input);

            String DRIVER = props.getProperty("DRIVER");
            String jdbc = props.getProperty("jdbc");
            String USUARIO = props.getProperty("USUARIO");
            String CLAVE = props.getProperty("CLAVE");

            if (jdbc == null || USUARIO == null || CLAVE == null) {
                throw new IllegalStateException("Una o más propiedades de conexión no están definidas");
            }

            Class.forName(DRIVER);
            con = DriverManager.getConnection(jdbc, USUARIO, CLAVE);
            System.out.println("Conexión exitosa a la base de datos");
        } catch (IOException | ClassNotFoundException | SQLException | IllegalStateException e) {
            System.err.println("Error en la conexión :(, error: " + e);
            JOptionPane.showMessageDialog(null, "Error en la conexión: " + e.toString());
        }
        return con;
    }
}