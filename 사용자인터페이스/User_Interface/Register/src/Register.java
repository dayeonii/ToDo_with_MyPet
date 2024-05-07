//회원가입 화면
import javax.swing.*;
import java.awt.*;

public class Register extends JFrame {
    public Register() {
        setTitle("Register User 화면");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        Container pane = getContentPane();
        pane.setLayout(new BorderLayout());

        //상단 메뉴바
        JPanel jpNorth = new JPanel();
        jpNorth.setBackground(Color.GRAY);
        jpNorth.setPreferredSize(new Dimension(100,40));
        jpNorth.setLayout(new BorderLayout());

        JLabel title = new JLabel("Register");
        title.setForeground(Color.WHITE);
        title.setFont(new Font("", Font.BOLD, 18));

        ImageIcon homeIcon = new ImageIcon("images/homeIcon.png");
        Image img = homeIcon.getImage();
        Image newimg = img.getScaledInstance(20,20,Image.SCALE_SMOOTH);
        homeIcon = new ImageIcon(newimg);
        JButton home = new JButton(homeIcon);

        JPanel leftPanel = new JPanel();
        leftPanel.setOpaque(false);
        leftPanel.setPreferredSize(new Dimension(90, 0));
        jpNorth.add(leftPanel, BorderLayout.WEST);  //여백
        jpNorth.add(title, BorderLayout.CENTER);
        jpNorth.add(home, BorderLayout.EAST);
        jpNorth.setBorder(BorderFactory.createEmptyBorder(6,5,5,5));

        //센터 아이디 패스워드 이름 입력
        JPanel jpCenter = new JPanel();
        jpCenter.setLayout(new GridBagLayout());
        JLabel idLabel = new JLabel("ID");          JTextField idField = new JTextField(15);
        JLabel pwLabel = new JLabel("Password");    JTextField pwField = new JTextField(15);
        JLabel pwcheckLabel = new JLabel("check PW");    JTextField pwcheckField = new JTextField(15);
        JLabel nameLabel = new JLabel("Name");      JTextField nameField = new JTextField(15);
        JLabel emailLabel = new JLabel("e-mail");   JTextField emailField = new JTextField(15);
        JButton confirmBT = new JButton("Confirm");
        JButton confirmID = new JButton("check id");
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.gridx = 0;      gbc.gridy = 0;
        gbc.anchor = GridBagConstraints.WEST;
        gbc.insets = new Insets(5,5,5,5);

        jpCenter.add(nameLabel, gbc);     gbc.gridx++;
        jpCenter.add(nameField, gbc);     gbc.gridy++;
        gbc.gridx=0;
        jpCenter.add(idLabel, gbc);     gbc.gridx++;
        jpCenter.add(idField, gbc);     gbc.gridy++;
        jpCenter.add(confirmID, gbc);   gbc.gridy++;
        gbc.gridx=0;
        jpCenter.add(pwLabel, gbc);     gbc.gridx++;
        jpCenter.add(pwField, gbc);     gbc.gridy++;
        gbc.gridx=0;
        jpCenter.add(pwcheckLabel, gbc);     gbc.gridx++;
        jpCenter.add(pwcheckField, gbc);     gbc.gridy++;
        gbc.gridx=0;
        jpCenter.add(emailLabel, gbc);     gbc.gridx++;
        jpCenter.add(emailField, gbc);     gbc.gridy++;
        gbc.gridx=0;
        gbc.gridwidth = 2;
        gbc.anchor = GridBagConstraints.CENTER;
        confirmBT.setPreferredSize(new Dimension(120,30));
        jpCenter.add(confirmBT, gbc);


        pane.add(jpNorth, BorderLayout.NORTH);
        pane.add(jpCenter,BorderLayout.CENTER);

        setSize(300, 520);
        setVisible(true);
    }

    public static void main(String[] args) {
        new Register();
    }
}
