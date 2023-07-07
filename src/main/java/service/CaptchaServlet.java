package service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

@WebServlet("/captcha-servlet")
public class CaptchaServlet extends HttpServlet {

    public static final String FILE_TYPE = "jpeg";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setHeader("Progma", "no-cache");
        response.setDateHeader("Max-Age", 0);

        String captcha = generateCaptcha(5);
        Random random = new Random();

        int width = 100, height = 40;
        BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.OPAQUE);
        Graphics graphics = bufferedImage.createGraphics();
        graphics.setFont(new Font("Arial", Font.BOLD, 25));
        graphics.setColor(new Color(234, 174, 32));
        graphics.fillRect(0, 0, width, height);
        graphics.setColor(new Color(248, 25, 25));
        graphics.drawString(captcha, 10, 25);
        for (int i = 0; i < 3; i++) {
            graphics.setColor(new Color(248, 25, 25));
            graphics.drawLine(0, random.nextInt(40), 100, random.nextInt(40));
            graphics.setColor(new Color(255, 232, 26));
            graphics.drawLine(0, random.nextInt(40), 100, random.nextInt(40));
            graphics.setColor(new Color(26, 255, 255));
            graphics.drawLine(0, random.nextInt(40), 100, random.nextInt(40));
        }
        HttpSession session = request.getSession(true);
        session.setAttribute("captchaValue", captcha);

        OutputStream outputStream = response.getOutputStream();
        ImageIO.write(bufferedImage, FILE_TYPE, outputStream);
        outputStream.close();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    private String generateCaptcha(int captchaLength) {
        String captcha = "1234567890";

        StringBuffer captchaBuffer = new StringBuffer();
        Random random = new Random();

        while (captchaBuffer.length() < captchaLength) {
            int index = (int) (random.nextFloat() * captcha.length());
            captchaBuffer.append(captcha.substring(index, index + 1));
        }
        return captchaBuffer.toString();
    }

}
