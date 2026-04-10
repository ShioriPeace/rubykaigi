# Step 4: メモ帳アプリ
#
# JTextArea = 複数行のテキスト入力欄
# JScrollPane = スクロールバーをつける部品
# File.write / File.read はRubyのファイル操作（Java関係なし）
#
# ポイント：GUIはJava、ファイル操作はRuby。いいとこ取り！

java_import javax.swing.JFrame
java_import javax.swing.JButton
java_import javax.swing.JTextArea
java_import javax.swing.JScrollPane
java_import javax.swing.JPanel
java_import javax.swing.JOptionPane
java_import java.awt.BorderLayout
java_import java.awt.Font

MEMO_FILE = File.join(__dir__, "memo.txt")

# ウィンドウ
frame = JFrame.new("かんたんメモ帳")
frame.set_size(500, 400)
frame.set_default_close_operation(JFrame::EXIT_ON_CLOSE)
frame.set_layout(BorderLayout.new)

# テキスト入力エリア
text_area = JTextArea.new
text_area.set_font(Font.new("sans-serif", Font::PLAIN, 16))
text_area.set_line_wrap(true)  # 右端で折り返す
scroll = JScrollPane.new(text_area)

# ボタンを横に並べるパネル
button_panel = JPanel.new

# 保存ボタン
save_button = JButton.new("保存")
save_button.add_action_listener do |event|
  File.write(MEMO_FILE, text_area.get_text)  # ← Rubyのファイル書き込み
  JOptionPane.show_message_dialog(frame, "保存したよ！（memo.txt）")
end

# 読み込みボタン
load_button = JButton.new("読み込み")
load_button.add_action_listener do |event|
  if File.exist?(MEMO_FILE)
    text_area.set_text(File.read(MEMO_FILE))  # ← Rubyのファイル読み込み
  else
    JOptionPane.show_message_dialog(frame, "まだ保存されたメモがないよ")
  end
end

# クリアボタン
clear_button = JButton.new("クリア")
clear_button.add_action_listener do |event|
  text_area.set_text("")
end

button_panel.add(save_button)
button_panel.add(load_button)
button_panel.add(clear_button)

frame.add(scroll, BorderLayout::CENTER)
frame.add(button_panel, BorderLayout::SOUTH)
frame.set_visible(true)
