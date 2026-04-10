# Step 3: おみくじアプリ
#
# .sample はRubyの機能。配列からランダムに1つ選ぶ。
# つまり「Rubyの便利さ」と「JavaのGUI」の合わせ技。

java_import javax.swing.JFrame
java_import javax.swing.JButton
java_import javax.swing.JLabel
java_import java.awt.BorderLayout
java_import java.awt.Font
java_import java.awt.Color

# おみくじの結果リスト
results = [
  { text: "大吉 🎉", color: Color::RED },
  { text: "中吉 ✨", color: Color::ORANGE },
  { text: "小吉 😊", color: Color.new(0, 150, 0) },
  { text: "吉 🙂",   color: Color::BLUE },
  { text: "末吉 😐", color: Color::GRAY },
  { text: "凶 💦",   color: Color::DARK_GRAY },
]

# ウィンドウ
frame = JFrame.new("おみくじ")
frame.set_size(400, 250)
frame.set_default_close_operation(JFrame::EXIT_ON_CLOSE)
frame.set_layout(BorderLayout.new)

# 結果表示
label = JLabel.new("ボタンを押してね", JLabel::CENTER)
label.set_font(Font.new("sans-serif", Font::BOLD, 40))

# ボタン
button = JButton.new("おみくじを引く")
button.set_font(Font.new("sans-serif", Font::PLAIN, 20))

button.add_action_listener do |event|
  result = results.sample  # ← Rubyの .sample でランダム選択
  label.set_text(result[:text])
  label.set_foreground(result[:color])
end

frame.add(label, BorderLayout::CENTER)
frame.add(button, BorderLayout::SOUTH)
frame.set_visible(true)
