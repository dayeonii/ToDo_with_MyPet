//메인화면, 투두리스트
import javax.swing.*;
import java.awt.*;
import java.awt.event.WindowStateListener;

public class ToDoList extends JFrame {
    public ToDoList() {
        setTitle("ToDo List 화면");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        Container pane = getContentPane();

        //상단 메뉴바
        JPanel jpNorth = new JPanel();
        jpNorth.setBackground(Color.GRAY);
        jpNorth.setPreferredSize(new Dimension(100,40));
        jpNorth.setLayout(new BorderLayout());

        //title
        JLabel title = new JLabel("To-Do");
        title.setHorizontalAlignment(SwingConstants.CENTER);
        title.setForeground(Color.WHITE);
        title.setFont(new Font("", Font.BOLD, 18));

        //좌측 상단 메뉴 버튼
        ImageIcon menuIcon = new ImageIcon("images/menuIcon.png");
        Image img = menuIcon.getImage();
        Image newimg = img.getScaledInstance(20,20,Image.SCALE_SMOOTH);
        menuIcon = new ImageIcon(newimg);
        JButton menuBT = new JButton(menuIcon);

        //우측 상단 펫 화면 버튼
        ImageIcon petIcon = new ImageIcon("images/petIcon.png");
        img = petIcon.getImage();
        newimg = img.getScaledInstance(20,20,Image.SCALE_SMOOTH);
        petIcon = new ImageIcon(newimg);
        JButton petBT = new JButton(petIcon);

        jpNorth.add(menuBT, BorderLayout.WEST);
        jpNorth.add(title, BorderLayout.CENTER);
        jpNorth.add(petBT, BorderLayout.EAST);
        jpNorth.setBorder(BorderFactory.createEmptyBorder(6,5,5,5));

        //center
        JPanel jpCenter = new JPanel();
        jpCenter.setLayout(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.gridx = 0;      gbc.gridy = 0;
        gbc.anchor = GridBagConstraints.CENTER;
        gbc.insets = new Insets(5,5,5,5);

        //오늘 날짜
        JLabel today = new JLabel("2024. 05. 06 MON");
        today.setFont(new Font("", Font.BOLD, 18));
        today.setHorizontalAlignment(SwingConstants.CENTER);
        jpCenter.add(today);    gbc.gridx++;

        //추가 버튼
        JButton addToDo = new JButton("+");
        gbc.anchor = GridBagConstraints.EAST;
        jpCenter.add(addToDo, gbc);     gbc.gridy++;    gbc.gridx=0;

        //날짜 밑에 구분선
        JPanel lineP = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                g.setColor(Color.BLACK);
                g.drawLine(0, getHeight()-1, getWidth(), getHeight()-1);
            }
        };
        lineP.setPreferredSize(new Dimension(today.getPreferredSize().width + addToDo.getPreferredSize().width + 5, 1)); // 선의 길이 설정
        gbc.gridx = 0;
        gbc.gridwidth = 2;
        jpCenter.add(lineP, gbc);   gbc.gridy++;

        //투두
        gbc.anchor = GridBagConstraints.WEST;
        JCheckBox first = new JCheckBox("소설 과제하기");
        jpCenter.add(first, gbc);       gbc.gridy++;
        JCheckBox second = new JCheckBox("교수님께 메일 보내기");
        jpCenter.add(second, gbc);      gbc.gridy++;
        JCheckBox third = new JCheckBox("방 청소하기");
        jpCenter.add(third, gbc);      gbc.gridy++;

        //달성률
        JPanel jpSouth = new JPanel();
        jpSouth.setLayout(new GridBagLayout());
        JProgressBar progress = new JProgressBar();
        progress.setValue(66);
        progress.setStringPainted(true);
        jpSouth.add(progress, gbc);     gbc.gridy++;

        //아이템받기
        JButton itemBT = new JButton("Get Items!");
        gbc.anchor = GridBagConstraints.CENTER;
        jpSouth.add(itemBT, gbc);

        pane.add(jpNorth, BorderLayout.NORTH);
        pane.add(jpCenter, BorderLayout.CENTER);
        pane.add(jpSouth, BorderLayout.SOUTH);
        setSize(300, 520);
        setVisible(true);
    }

    public static void main(String[] args) {
        new ToDoList();
    }
}
