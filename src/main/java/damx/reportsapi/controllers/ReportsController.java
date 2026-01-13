package damx.reportsapi.controllers;

import damx.reportsapi.services.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.FileNotFoundException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/reports")

public class ReportsController {

    @Autowired
    private ReportService reportService;

    // REPORTS PARA STREAMING
    @GetMapping("/getSeries1/{dispositivo}")
    public ResponseEntity<byte[]> getSeries1(@PathVariable String dispositivo) {
        System.out.println("Obteniendo informe series 1");
        try {
            Map<String, Object> parms = new HashMap<>(); // Aquí van los parámetros/filtros (si son necesarios)
            parms.put("dispositivos", dispositivo);
            byte[] report = reportService.generarReport("series1", parms); // Indicar nombre del archivo .jasper
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.add("Content-Disposition","inline; filename=report.pdf");
            return new ResponseEntity<>(report, headers, HttpStatus.OK);

        } catch (FileNotFoundException e) {
            System.out.println(e.getMessage());

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }



    /*
    *
    * REPORTS PARA ERCIHUELLAS
    *
    * */
    @GetMapping("/getReport")
    public ResponseEntity<byte[]> getEvents(){
        System.out.println("Obteniendo informe");
        try {
            Map<String, Object> parms = new HashMap<>(); // Aquí van los parámetros/filtros (si son necesarios)
            byte[] report = reportService.generarReport("Personas", parms); // Indicar nombre del archivo .jasper
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.add("Content-Disposition","inline; filename=report.pdf");
            return new ResponseEntity<>(report, headers, HttpStatus.OK);

        } catch (FileNotFoundException e) {
            System.out.println(e.getMessage());

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    @GetMapping("/getAdopciones/{estado}")
    public ResponseEntity<byte[]> getAdopciones(@PathVariable String estado){
        System.out.println("Obteniendo informe");
        try {
            Map<String, Object> parms = new HashMap<>(); // Aquí van los parámetros/filtros (si son necesarios)
            parms.put("estado", estado);
            byte[] report = reportService.generarReport("Adopciones", parms); // Indicar nombre del archivo .jasper
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.add("Content-Disposition","inline; filename=report.pdf");
            return new ResponseEntity<>(report, headers, HttpStatus.OK);

        } catch (FileNotFoundException e) {
            System.out.println(e.getMessage());

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    @GetMapping("/voluntarios/{id_animal}")
    public ResponseEntity<byte[]> getVolutarios(@PathVariable Integer id_animal){
        System.out.println("Obteniendo informe");
        try {
            Map<String, Object> parms = new HashMap<>(); // Aquí van los parámetros/filtros (si son necesarios)
            parms.put("id_animal", id_animal);
            byte[] report = reportService.generarReport("Voluntarios", parms); // Indicar nombre del archivo .jasper
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.add("Content-Disposition","inline; filename=report.pdf");
            return new ResponseEntity<>(report, headers, HttpStatus.OK);

        } catch (FileNotFoundException e) {
            System.out.println(e.getMessage());

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    @GetMapping("/animales/{fecha1}/{fecha2}")
    public ResponseEntity<byte[]> getAnimalesFecha(@PathVariable Date fecha1,
                                                   @PathVariable Date fecha2){
        System.out.println("Obteniendo informe");
        try {
            Map<String, Object> parms = new HashMap<>(); // Aquí van los parámetros/filtros (si son necesarios)
            parms.put("fecha1", fecha1);
            parms.put("fecha2", fecha2);
            byte[] report = reportService.generarReport("AnimalesFechas", parms); // Indicar nombre del archivo .jasper
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.add("Content-Disposition","inline; filename=report.pdf");
            return new ResponseEntity<>(report, headers, HttpStatus.OK);

        } catch (FileNotFoundException e) {
            System.out.println(e.getMessage());

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

}
