import java.awt.BorderLayout;
import java.awt.EventQueue;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.TransferHandler;

private class DropFileHandler extends TransferHandler {
  List<File> currentFiles;
  List<File> portList;

  DropFileHandler(List<File> _portList) {
    super();
    currentFiles=null;
    portList=_portList;
  }

  //ドロップされたものを受け取るか判断 (ファイルのときだけ受け取る)
  @Override
    public boolean canImport(TransferSupport support) {
    if (!support.isDrop()) {
      // ドロップ操作でない場合は受け取らない
      return false;
    }

    if (!support.isDataFlavorSupported(DataFlavor.javaFileListFlavor)) {
      // ドロップされたのがファイルでない場合は受け取らない
      return false;
    }

    return true;
  }


  //ドロップされたファイルを受け取る
  @Override
    public boolean importData(TransferSupport support) {
    // 受け取っていいものか確認する
    if (!canImport(support)) {
      return false;
    }

    // ドロップ処理
    Transferable t = support.getTransferable();
    try {
      // ファイルを受け取る
      currentFiles = (List<File>) t.getTransferData(DataFlavor.javaFileListFlavor);

      for (File file : currentFiles) {
        portList.add(file);
      }
    } 
    catch (IOException e) {
      e.printStackTrace();
    } 
    catch(UnsupportedFlavorException ue) {
      ue.printStackTrace();
    }
    return true;
  }
}
