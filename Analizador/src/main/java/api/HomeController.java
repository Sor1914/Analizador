package api;

import api.models.textRequest;
import org.springframework.web.bind.annotation.*;

import java.io.*;

@RestController
@RequestMapping("/api")
public class HomeController {

    @PostMapping("/analizador")
    public String analizarTexto(@RequestBody textRequest request) {
        StringWriter salidaErrores = new StringWriter();
        PrintWriter pw = new PrintWriter(salidaErrores);
        PrintStream originalErr = System.err;
        PrintStream errRedirigido = new PrintStream(new OutputStream() {
            public void write(int b) {
                pw.write(b);
            }
        });

        try {
            System.setErr(errRedirigido);
            Reader r = new StringReader(request.getBody());
            AnalizadorLexico al = new AnalizadorLexico(r);
            parser p = new parser(al);
            p.parse();
            pw.println("✔ Análisis completado sin errores.");

        } catch (Exception e) {
            pw.println("Error: " + e.getMessage());
        } finally {
            System.setErr(originalErr);
        }

        pw.flush();
        return salidaErrores.toString();
    }

}
