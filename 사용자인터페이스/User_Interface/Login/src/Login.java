//초기 앱 실행 시 로그인 화면
import javax.swing.*;
import java.awt.*;

public class Login extends JFrame {
    public Login() {
        setTitle("Login 화면");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        GridLayout grid = new GridLayout(3,1);
        Container pane = getContentPane();
        pane.setLayout(grid);

        JPanel jpCenter = new JPanel();
        //jpCenter.setLayout(new GridLayout(3,1));
        jpCenter.setLayout(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.gridx = 0;
        gbc.gridy = 0;
        gbc.insets = new Insets(5,0,5,0);

        JTextField idField = new JTextField();
        idField.setPreferredSize(new Dimension(250, 30));
        JTextField pwField = new JTextField();
        pwField.setPreferredSize(new Dimension(250, 30));

        jpCenter.add(new JLabel("ID"), gbc);    gbc.gridx++;
        jpCenter.add(idField, gbc);     gbc.gridy++;
        gbc.gridx = 0;
        jpCenter.add(new JLabel("PW"), gbc);    gbc.gridx++;
        jpCenter.add(pwField, gbc);     gbc.gridy++;
        gbc.gridx = 0;
        gbc.gridwidth = 2;
        JButton loginButton = new JButton("login");
        loginButton.setPreferredSize(new Dimension(150,30));
        jpCenter.add(loginButton, gbc);     gbc.gridy++;
        JLabel regiLabel = new JLabel("<html><u>Register</u></html>");
        regiLabel.setFont(new Font("", Font.PLAIN, 10));
        jpCenter.add(regiLabel, gbc);

        JLabel title = new JLabel("To-Do with My Pet");
        title.setFont(new Font("", Font.BOLD, 24));
        title.setHorizontalAlignment(SwingConstants.CENTER);
        title.setVerticalAlignment(SwingConstants.CENTER);
        pane.add(title);
        pane.add(jpCenter);
        pane.add(new JPanel());

        setSize(300, 520);
        setVisible(true);
    }

    public static void main(String [] args) {
        new Login();
    }
}
