//상단 메뉴버튼을 누르면 나오는 리스트 (각 화면을 이동할 수 있고, 로그아웃이 가능)
import javax.swing.*;
import java.awt.*;

public class Menu extends JFrame {
    public Menu() {
        setTitle("Menu 화면");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(300, 520);
        Container pane = getContentPane();
        pane.setLayout(new BorderLayout());

        //화면 분할
        JPanel menuPanel = new JPanel(new BorderLayout());
        menuPanel.setBackground(Color.GRAY);
        menuPanel.setPreferredSize(new Dimension(300*3/4, 520));

        //버튼
        JPanel jpNorth = new JPanel(new FlowLayout(FlowLayout.RIGHT));
        jpNorth.setOpaque(false);
        //우측 상단 메뉴 버튼
        ImageIcon menuIcon = new ImageIcon("images/menuIcon.png");
        Image img = menuIcon.getImage();
        Image newimg = img.getScaledInstance(20,20,Image.SCALE_SMOOTH);
        menuIcon = new ImageIcon(newimg);
        JButton menuBT = new JButton(menuIcon);
        jpNorth.add(menuBT);

        //내비게이션 메뉴
        JPanel jpCenter = new JPanel(new GridBagLayout());
        jpCenter.setOpaque(false);
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.gridx = 0;      gbc.gridy = 0;
        gbc.anchor = GridBagConstraints.WEST;
        gbc.insets = new Insets(10,5,10,5);
        JLabel menu1 = new JLabel("To-Do");
        menu1.setFont(new Font("", Font.PLAIN, 18));    menu1.setForeground(Color.WHITE);
        JLabel menu2 = new JLabel("My Pet");
        menu2.setFont(new Font("", Font.PLAIN, 18));    menu2.setForeground(Color.WHITE);
        JLabel menu3 = new JLabel("Friends");
        menu3.setFont(new Font("", Font.PLAIN, 18));    menu3.setForeground(Color.WHITE);
        jpCenter.add(menu1, gbc);   gbc.gridy++;
        jpCenter.add(menu2, gbc);   gbc.gridy++;
        jpCenter.add(menu3, gbc);   gbc.gridy++;

        //로그아웃
        JPanel jpSouth = new JPanel();
        jpSouth.setOpaque(false);
        JButton logoutBT = new JButton("logout");
        jpSouth.add(logoutBT);

        menuPanel.add(jpCenter, BorderLayout.CENTER);
        menuPanel.add(jpNorth, BorderLayout.NORTH);
        menuPanel.add(jpSouth, BorderLayout.SOUTH);

        pane.add(menuPanel, BorderLayout.WEST);

        setVisible(true);
    }

    public static void main(String [] args) {
        new Menu();
    }
}
