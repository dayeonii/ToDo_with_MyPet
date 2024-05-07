//펫 화면
import javafx.scene.control.ProgressBar;

import javax.swing.*;
import java.awt.*;

public class MyPet extends JFrame {
    public MyPet() {
        setTitle("My Pet 화면");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        Container pane = getContentPane();
        pane.setLayout(new BorderLayout());

        //상단
        JPanel jpNorth = new JPanel();
        jpNorth.setLayout(new BorderLayout());
        jpNorth.setBackground(Color.GRAY);
        jpNorth.setPreferredSize(new Dimension(100,40));

        //title
        JLabel title = new JLabel("My Pet");
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
        ImageIcon todoIcon = new ImageIcon("images/todoIcon.png");
        img = todoIcon.getImage();
        newimg = img.getScaledInstance(20,20,Image.SCALE_SMOOTH);
        todoIcon = new ImageIcon(newimg);
        JButton todoBT = new JButton(todoIcon);

        jpNorth.add(menuBT, BorderLayout.WEST);
        jpNorth.add(title, BorderLayout.CENTER);
        jpNorth.add(todoBT, BorderLayout.EAST);
        jpNorth.setBorder(BorderFactory.createEmptyBorder(6,5,5,5));

        //센터
        JPanel jpCenter = new JPanel();
        jpCenter.setLayout(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.gridx=0;    gbc.gridy=0;
        gbc.insets = new Insets(10,0,0,0);
        //펫 수치
        JLabel hungry = new JLabel("배고픔");
        hungry.setFont(new Font("", Font.PLAIN, 14));
        jpCenter.add(hungry, gbc);   gbc.gridx++;
        JProgressBar progressH = new JProgressBar();
        progressH.setValue(40);
        progressH.setStringPainted(false);
        jpCenter.add(progressH, gbc);    gbc.gridy++;    gbc.gridx=0;

        JLabel bold = new JLabel("심심함");
        bold.setFont(new Font("", Font.PLAIN, 14));
        jpCenter.add(bold, gbc);   gbc.gridx++;
        JProgressBar progressB = new JProgressBar();
        progressB.setValue(80);
        progressB.setStringPainted(false);
        jpCenter.add(progressB, gbc);    gbc.gridy++;    gbc.gridx=0;

        //펫
        gbc.insets = new Insets(50,30,0,0);
        ImageIcon cat = new ImageIcon("images/catImage.png");
        Image catImg = cat.getImage().getScaledInstance(120,120,Image.SCALE_SMOOTH);
        JLabel catLabel = new JLabel(new ImageIcon(catImg));
        catLabel.setHorizontalAlignment(SwingConstants.CENTER);
        gbc.gridwidth=2;
        jpCenter.add(catLabel, gbc);    gbc.gridy++;

        //아이템
        JPanel itemPanel = new JPanel(new FlowLayout());
        itemPanel.setBackground(Color.WHITE);
        itemPanel.setBorder(BorderFactory.createEmptyBorder(5,5,5,5));

        //먹이
        ImageIcon foodIcon = new ImageIcon("images/foodImage.png");
        Image foodImg = foodIcon.getImage().getScaledInstance(20, 20, Image.SCALE_SMOOTH);
        JLabel foodLabel = new JLabel(new ImageIcon(foodImg));
        JTextField foodCount = new JTextField("5");
        foodCount.setPreferredSize(new Dimension(30, 20));
        foodCount.setEditable(false);
        foodCount.setBackground(Color.WHITE);
        itemPanel.add(foodLabel);
        itemPanel.add(foodCount);
        //장난감
        ImageIcon toyIcon = new ImageIcon("images/toyImage.png");
        Image toyImg = toyIcon.getImage().getScaledInstance(20, 20, Image.SCALE_SMOOTH);
        JLabel toyLabel = new JLabel(new ImageIcon(toyImg));
        JTextField toyCount = new JTextField("3");
        toyCount.setPreferredSize(new Dimension(30, 20));
        toyCount.setEditable(false);
        toyCount.setBackground(Color.WHITE);
        itemPanel.add(toyLabel);
        itemPanel.add(toyCount);

        jpCenter.add(itemPanel, gbc);   gbc.gridy++;

        //버튼
        JPanel jpSouth = new JPanel();
        jpSouth.setLayout(new GridLayout(1,2));
        JButton feeding = new JButton("먹이주기");
        JButton playing = new JButton("놀아주기");
        jpSouth.add(feeding);
        jpSouth.add(playing);

        pane.add(jpNorth, BorderLayout.NORTH);
        pane.add(jpCenter, BorderLayout.CENTER);
        pane.add(jpSouth, BorderLayout.SOUTH);
        setSize(300, 520);
        setVisible(true);
    }

    public static void main(String[] args) {
        new MyPet();
    }
}
