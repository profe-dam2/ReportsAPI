package damx.reportsapi.services;

import damx.reportsapi.database.SQLDatabaseManager;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import org.springframework.stereotype.Service;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;


@Service
public class ReportService {

    private Connection connection;

    private boolean initDBConnection(){
        try {
            connection = SQLDatabaseManager.connect();
            return true;
        } catch (SQLException e) {
            System.err.println("Error al conectar con la base de datos");
        }
        return false;
    }

    private boolean closeDBConnection(){
        try {
            SQLDatabaseManager.disconnect(connection);
            return true;
        } catch (SQLException e) {
            System.err.println("Error al desconectar con la base de datos");
        }
        return false;
    }

    public byte[] generarReport(String reportName,  Map<String, Object> parms) throws Exception {

        if (!initDBConnection()) {
            throw new SQLException("Error al conectar con la base de datos");
        }

        InputStream reportStream = new FileInputStream("src/main/resources/reports/" + reportName + ".jasper");


        if (reportStream == null) {
            throw new JRException("El informe no se encontró: " + reportName);
        }

        JasperPrint jasperPrint = JasperFillManager.fillReport(reportStream, parms, connection);
        closeDBConnection();
        return JasperExportManager.exportReportToPdf(jasperPrint);
    }

}
