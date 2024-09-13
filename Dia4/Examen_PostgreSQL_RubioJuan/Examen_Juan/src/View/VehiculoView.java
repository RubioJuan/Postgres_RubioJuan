package View;

import Controller.VehiculoController;
import Model.Vehiculo;
import java.util.List;
import java.util.Scanner;

public class VehiculoView {

    private VehiculoController vehiculoController;
    private Scanner scanner;

    // Constructor
    public VehiculoView() {
        this.scanner = new Scanner(System.in);
    }

    // Método para establecer el controlador
    public void setVehiculoController(VehiculoController vehiculoController) {
        this.vehiculoController = vehiculoController;
    }

    // Método para mostrar el menú
    public void mostrarMenu() {
        int opcion;
        do {
            System.out.println("\n--- Menú de Vehículos ---");
            System.out.println("1. Ver vehículos disponibles");
            System.out.println("2. Ver el total de vehículos");
            System.out.println("3. Salir");
            System.out.print("Selecciona una opción: ");
            
            opcion = scanner.nextInt();
            scanner.nextLine(); // Limpiar el buffer del scanner

            switch (opcion) {
                case 1:
                    mostrarVehiculosDisponibles();
                    break;
                case 2:
                    mostrarTotalVehiculos();
                    break;
                case 3:
                    System.out.println("Saliendo del programa...");
                    break;
                default:
                    System.out.println("Opción no válida. Inténtalo de nuevo.");
            }
        } while (opcion != 3);
    }

    // Método para actualizar la vista con los vehículos disponibles
    public void mostrarVehiculosDisponibles() {
        List<Vehiculo> vehiculos = vehiculoController.obtenerVehiculosDisponibles();
        if (vehiculos != null) {
            // Lógica para actualizar la vista con la lista de vehículos
            for (Vehiculo vehiculo : vehiculos) {
                System.out.println("ID: " + vehiculo.getId() + ", Marca: " + vehiculo.getMarca() +
                                   ", Modelo: " + vehiculo.getModelo() + ", Año: " + vehiculo.getAnio() +
                                   ", Precio: " + vehiculo.getPrecio() + ", Estado: " + vehiculo.getEstado());
            }
        } else {
            // Manejo de la situación donde no se obtuvieron vehículos
            System.out.println("No se pudieron obtener los vehículos disponibles.");
        }
    }

    // Método para mostrar el total de vehículos
    private void mostrarTotalVehiculos() {
        List<Vehiculo> vehiculos = vehiculoController.obtenerVehiculosDisponibles();
        if (vehiculos != null) {
            System.out.println("Total de vehículos disponibles: " + vehiculos.size());
        } else {
            System.out.println("No se pudieron obtener los vehículos disponibles.");
        }
    }
}