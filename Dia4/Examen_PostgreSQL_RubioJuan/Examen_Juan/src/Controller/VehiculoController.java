package Controller;

import DAO.VehiculoDao;
import Model.Vehiculo;
import java.sql.SQLException;
import java.util.List;

public class VehiculoController {
    private VehiculoDao vehiculoDao;

    // Constructor que acepta VehiculoDao
    public VehiculoController(VehiculoDao vehiculoDao) {
        this.vehiculoDao = vehiculoDao;
    }

    // Método para obtener la lista de vehículos disponibles
    public List<Vehiculo> obtenerVehiculosDisponibles() {
        try {
            return vehiculoDao.listarVehiculosDisponibles();
        } catch (SQLException e) {
            e.printStackTrace();
            // Manejo del error (por ejemplo, mostrar un mensaje de error en la vista)
            return null;
        }
    }
}