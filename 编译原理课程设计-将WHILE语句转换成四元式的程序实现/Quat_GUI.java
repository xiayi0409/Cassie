package 课程设计;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Queue;
import javax.swing.BorderFactory;
import javax.swing.DefaultListModel;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.WindowConstants;
import javax.swing.border.Border;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumn;
import javax.swing.table.TableColumnModel;

public class Quat_GUI extends JFrame implements ActionListener , MouseListener {    
	private DefaultListModel dlm =new DefaultListModel();    
	private JList jList = new JList();
    private JButton btn1,btn2;
    private JTextArea raw;
    private DefaultTableModel parsing,outcome;
    private JFileChooser jfc;
    private File file;
    
	public Quat_GUI(){
        super("while语句四元式生成器");
        this.getContentPane().setBackground(Color.WHITE);
        this.setSize(850,600);
        this.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        this.setLayout(new BorderLayout());

        JPanel left=new JPanel(new BorderLayout());
        left.setName("文件");
        jList=new JList<File>(dlm);
        jList.addMouseListener(this);
        jList.setVisibleRowCount(31);
        JScrollPane jsp1=new JScrollPane(jList);
        Border titleBorder1 = BorderFactory.createTitledBorder("文件列表");
        jsp1.setBorder(titleBorder1);
        left.add(jsp1,BorderLayout.NORTH);
        JPanel jp1=new JPanel(new FlowLayout());
        btn1=new JButton("打开文件");
        btn2=new JButton("开始生成");
        btn1.addActionListener(this);
        btn2.addActionListener(this);
        jp1.add(btn1);
        jp1.add(new JLabel(" "));
        jp1.add(btn2);
        left.add(jp1,BorderLayout.SOUTH);
        JSplitPane sp1=new JSplitPane(JSplitPane.HORIZONTAL_SPLIT);
        sp1.add(left,JSplitPane.LEFT);

        JPanel right=new JPanel(new BorderLayout());
        sp1.add(right,JSplitPane.RIGHT);
        @SuppressWarnings("unused")
		JPanel jp2=new JPanel();
        JSplitPane sp2=new JSplitPane(JSplitPane.VERTICAL_SPLIT);
        raw=new JTextArea();
        raw.setEditable(false);
        raw.setFont(new Font("宋体",1,20));
        JScrollPane jsp2=new JScrollPane(raw);
        Border titleBorder2 = BorderFactory.createTitledBorder("while语句");
        jsp2.setBorder(titleBorder2);
        sp2.add(jsp2,JSplitPane.TOP);

        String[] head1={"<no>","四元式"};
        outcome=new DefaultTableModel(head1,0);
        JTable jTable1=new JTable(outcome);
        TableColumnModel cm = jTable1.getColumnModel();
        TableColumn column = cm.getColumn(0);
        column.setPreferredWidth(1);
        jTable1.setFont(new Font("宋体",1,16));
        jTable1.setRowHeight(25);
        JScrollPane jsp3=new JScrollPane(jTable1);
        Border titleBorder3 = BorderFactory.createTitledBorder("四元式");
        jsp3.setBorder(titleBorder3);
        sp2.add(jsp3,JSplitPane.BOTTOM);
        JSplitPane sp3=new JSplitPane(JSplitPane.HORIZONTAL_SPLIT);
        sp3.add(sp2,JSplitPane.LEFT);

        String [] head2={"词语","类型"};
        parsing=new DefaultTableModel(head2,0);
        JTable jTable2=new JTable(parsing);
        jTable2.setFont(new Font("宋体",1,16));
        jTable2.setRowHeight(25);
        JScrollPane jsp4=new JScrollPane(jTable2);
        Border titleBorder4 = BorderFactory.createTitledBorder("词法分析");
        jsp4.setBorder(titleBorder4);
        sp3.add(jsp4,JSplitPane.RIGHT);
        right.add(sp3,BorderLayout.CENTER);
        this.getContentPane().add(sp1);

        jfc=new JFileChooser();
        jfc.setCurrentDirectory(new File("d://workspace//BianYiYuanLi"));

        this.setVisible(true);
        sp3.setDividerLocation(0.70);
        sp1.setDividerLocation(0.25);
        sp2.setDividerLocation(0.38);

    }
    public void readfile() throws IOException {
        FileInputStream fis=new FileInputStream(file);
        InputStreamReader isr=new InputStreamReader(fis);
		BufferedReader bfr=new BufferedReader(isr);
        String s="";
        this.raw.setText("");
        while((s=bfr.readLine())!=null) {
            this.raw.append(s);
            this.raw.append("\n");
        }
    }
	@Override
    public void actionPerformed(ActionEvent e) {
        if(e.getActionCommand().equals("打开文件")){
            int state = jfc.showOpenDialog(null);
            if (state == 1) {
            } else {
                this.file = jfc.getSelectedFile();
                try {
                    readfile();
                    dlm.addElement(file);
                    jList.setModel(dlm);
                } catch (IOException ioException) {
                    ioException.printStackTrace();
                }
            }
        }
        if (e.getActionCommand().equals("开始生成")){
            if(this.file==null){
                JOptionPane.showMessageDialog(null,"未打开文件!","错误",1);
            }
            else {
            	ConstructQuaternion constructQuaternion=new ConstructQuaternion();
                try {
                	Queue<Quaternion>queue = constructQuaternion.semantic(file.getAbsolutePath());
                    String str[][]=constructQuaternion.getLexer();
                    parsing.setRowCount(0);
                    for (int i=0;i<str.length;i++){
                        parsing.addRow(str[i]);
                    }
                    outcome.setRowCount(0);
                    String [] ss={constructQuaternion.getParsing(),""};
                    outcome.addRow(ss);
                    int size=queue.size();
                    if(queue.size()>0){
                        for(int i=0;i<size;i++){
                            if(queue.peek().getresult().equals("?"))
                                queue.peek().setresult("<"+(size+1)+">");
                            Quaternion ele=queue.poll();
                            String [] s={"<"+ele.gettable()+">","("+ele.getop()+", "+ele.getarg2()+", "+ele.getarg1()+", "+ele.getresult()+")"};
                            outcome.addRow(s);
                        }
                    }
                } catch (IOException ioException) {
                    ioException.printStackTrace();
                }
            }
        }
    }
    @Override
    public void mouseClicked(MouseEvent e) {
        if (jList.getSelectedIndex() != -1) {
            if (e.getClickCount() == 2) {
                this.file = (File) jList.getSelectedValue();
                try {
                    readfile();
                } catch (IOException ioException) {
                    ioException.printStackTrace();
                }
            }
        }
    }

    @Override
    public void mousePressed(MouseEvent e) {
    }

    @Override
    public void mouseReleased(MouseEvent e) {
    }

    @Override
    public void mouseEntered(MouseEvent e) {
    }

    @Override
    public void mouseExited(MouseEvent e) {
    }
    
    public static void main(String args[]){
		Quat_GUI Quat_GUI=new Quat_GUI();
    }
}
