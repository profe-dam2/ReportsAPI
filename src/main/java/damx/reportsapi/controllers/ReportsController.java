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
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/reports")

public class ReportsController {

    @Autowired
    private ReportService reportService;

    @GetMapping("/getReport")
    public ResponseEntity<byte[]> getEvents(){
        System.out.println("Obteniendo informe");

        try {
            Map<String, Object> parms = new HashMap<>(); // Aquí van los parámetros/filtros (si son necesarios)
            byte[] report = reportService.generarReport("<NOMBREINFORME>", parms); // Indicar nombre del archivo .jasper
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
