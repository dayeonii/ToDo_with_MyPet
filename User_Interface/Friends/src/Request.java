import javax.swing.*;
import java.awt.*;

public class Request extends JFrame {
    public Request() {
        setTitle("Friends Request 화면");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        Container pane = getContentPane();

        //상단 메뉴바
        JPanel jpNorth = new JPanel();
        jpNorth.setBackground(Color.GRAY);
        jpNorth.setPreferredSize(new Dimension(100, 40));
        jpNorth.setLayout(new BorderLayout());

        //title
        JLabel title = new JLabel("Friends Request");
        title.setHorizontalAlignment(SwingConstants.CENTER);
        title.setForeground(Color.WHITE);
        title.setFont(new Font("", Font.BOLD, 18));
        jpNorth.add(title, BorderLayout.CENTER);

        //좌측 상단 메뉴 버튼
        ImageIcon menuIcon = new ImageIcon("images/menuIcon.png");
        Image img = menuIcon.getImage();
        Image newimg = img.getScaledInstance(20, 20, Image.SCALE_SMOOTH);
        menuIcon = new ImageIcon(newimg);
        JButton menuBT = new JButton(menuIcon);
        jpNorth.add(menuBT, BorderLayout.WEST);
        jpNorth.setBorder(BorderFactory.createEmptyBorder(6, 5, 5, 5));

        //우측 상단 친구 추가 버튼
        ImageIcon requestIcon = new ImageIcon("images/requestIcon.png");
        img = requestIcon.getImage();
        newimg = img.getScaledInstance(20, 20, Image.SCALE_SMOOTH);
        requestIcon = new ImageIcon(newimg);
        JButton requestBT = new JButton(requestIcon);
        jpNorth.add(requestBT, BorderLayout.EAST);

        //검색창 및 친구 목록
        JPanel jpCenter = new JPanel(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.gridx = 0;
        gbc.gridy = 0;
        gbc.anchor = GridBagConstraints.CENTER;

        //검색창
        JPanel searchPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 5, 5));
        searchPanel.setBackground(Color.WHITE);
        searchPanel.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
        ImageIcon searchIcon = new ImageIcon("images/searchIcon.png");
        Image search = searchIcon.getImage().getScaledInstance(15, 15, Image.SCALE_SMOOTH);
        JLabel searchLabel = new JLabel(new ImageIcon(search));
        searchPanel.add(searchLabel);
        JTextField searchField = new JTextField(20);
        searchPanel.add(searchField);
        gbc.gridwidth = 2;
        jpCenter.add(searchPanel, gbc);
        gbc.gridy++;
        gbc.gridwidth = 1;

        //친구 프로필
        JPanel friendPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 10, 10));
        friendPanel.setBackground(Color.WHITE);
        ImageIcon profileIcon = new ImageIcon("images/profileIcon.png");
        Image profile = profileIcon.getImage().getScaledInstance(30, 30, Image.SCALE_SMOOTH);
        JLabel profileLabel = new JLabel(new ImageIcon(profile));
        friendPanel.add(profileLabel);
        JLabel nameLabel = new JLabel("새로운 친구");
        friendPanel.add(nameLabel);
        JButton acceptButton = new JButton("O");
        JButton rejectButton = new JButton("X");
        friendPanel.add(acceptButton);
        friendPanel.add(rejectButton);
        jpCenter.add(friendPanel, gbc);

        pane.add(jpNorth, BorderLayout.NORTH);
        pane.add(jpCenter, BorderLayout.CENTER);
        setSize(300, 520);
        setVisible(true);
    }

    public static void main(String[] args) {
        new Request();
    }
}
