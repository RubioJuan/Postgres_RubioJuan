/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package examen_juan;

import DAO.*;
import Controller.*;
import View.*;
import java.util.InputMismatchException;
import java.util.Scanner;

/**
 *
 * @author Juan Felipe Rubio
 */

public class Main {
      public static void main(String[] args) {
      Scanner scanner = new Scanner(System.in);
        
        int errores = 0;  

            while (true) {
                System.out.print("\033[H\033[2J");
                System.out.flush();

                System.out.println("╔══════════════════════════════════════════════════════════════════════════════════════════╗");
                System.out.println("║                              Panel de Control                               ║");
                System.out.println("╚══════════════════════════════════════════════════════════════════════════════════════════╝");
                System.out.println("║Hola usuario, bienvenido a nuestro software de gestión de eventos.           ║");
                System.out.println("║¿Con qué rol te identificas en nuestra compañía?                             ║");
                System.out.println("║                                                                             ║"  );
                System.out.println("║1. Vehiculos                                                   ║");
                System.out.println("║2. Encargado de Actividades                                                  ║");
                System.out.println("║3. Administrador de restaurante                                              ║");
                System.out.println("║4. Administrador de tiendas                                                  ║");
                System.out.println("║5. Encargado de taquilla                                                     ║");
                System.out.println("║6. Salir del sistema                                                         ║");
                System.out.println("║══════════════════════════════════════════════════════════════════════════════════════════║");
                System.out.print("Por favor, selecciona una opción: ");

                int opcion = 0;

                try {
                    opcion = scanner.nextInt(); 
                    errores = 0; 

                    switch (opcion) {
                        case 1:
                            vehiculos(scanner);
                            break;
                        case 2:
                            break;
                        case 3:
                            break;
                        case 4:
                            break;
                        case 5:
                            break;
                        case 6:
                        System.out.println("Saliendo del sistema.");
                        return; 
                        default:
                            errores++;
                            if (errores < 3) {
                                System.out.println("Opción no válida. Por favor selecciona una opción entre 1 y 5.");
                            } else {
                                System.out.println("Has cometido varios errores. Por favor, selecciona una opción válida.");
                            }
                            scanner.nextLine(); 
                            break;
                    }
                } catch (InputMismatchException e) {

                    System.out.println("Entrada no válida. Por favor ingresa un número entero.");
                    errores++;
                    scanner.nextLine(); 
                    if (errores >= 3) {
                        System.out.println("Has cometido varios errores. Por favor, selecciona una opción válida.");
                    }
                }

                if (opcion >= 1 && opcion <= 6) {
                    break;
                }
            }

            scanner.close();
        }

      // -----------------------------------------------------------------
      //----------------------- VEHICULOS ---------------------
      //------------------------------------------------------------------

    private static void vehiculos(Scanner scanner) {
        int errores = 0; 

        while (true) {
            System.out.println("╔══════════════════════════════════════════════════════════════════════════════════════════╗");
            System.out.println("║                      Panel de Administración de Eventos                     ║");
            System.out.println("╚══════════════════════════════════════════════════════════════════════════════════════════╝");
            System.out.println("║Hola Administrador, te damos la bienvenida a nuestro panel de administración ║");
            System.out.println("║de eventos, ¿Podrías regalarnos tu nombre para referirnos a ti?              ║");
            System.out.print("Por favor, ingresa tu nombre: ");
            String nombre = scanner.next();
            System.out.println("Listo " + nombre + ", en esta sección podrás entrar a los siguientes módulos:");
            System.out.println("║1. Gestionar de vehiculos                                                         ║");
            System.out.println("║2. Revisar informes                                                          ║");
            System.out.println("║3. Configurar eventos                                                        ║");
            System.out.println("║4. Panel de archivo Excel CRM                                                ║");
            System.out.println("║5. Inventario del evento                                                     ║");
            System.out.println("║6. Volver                                                                    ║");
            System.out.println("║══════════════════════════════════════════════════════════════════════════════════════════║");
            System.out.print("Por favor, selecciona una opción: ");

            int opcion = 0;

            try {
                opcion = scanner.nextInt(); 
                errores = 0; 

                switch (opcion) {
                    case 1:
                        System.out.println("Seleccionaste vehiculos.");
                        VehiculoDao vehiculoDao = new VehiculoDao();        
                        VehiculoController vehiculoController = new VehiculoController(vehiculoDao);
                        VehiculoView vehiculoView = new VehiculoView();
                        vehiculoView.setVehiculoController(vehiculoController);
                        vehiculoView.mostrarMenu();
                        break;
                    case 2:
                        
                        break;
                    case 3:
                        System.out.println("Seleccionaste configurar eventos.");
                        
                        break;
                }
              } catch (InputMismatchException e) {

                    System.out.println("Entrada no válida. Por favor ingresa un número entero.");
                    errores++;
                    scanner.nextLine(); 
                    if (errores >= 3) {
                        System.out.println("Has cometido varios errores. Por favor, selecciona una opción válida.");
                    }
                }

                if (opcion >= 1 && opcion <= 6) {
                    break;
                }
            }

            scanner.close();
        }
}
