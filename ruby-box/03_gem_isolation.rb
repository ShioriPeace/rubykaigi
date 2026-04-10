# Step 3: 設定の隔離
#
# 実行方法:
#   RUBY_BOX=1 ruby 03_gem_isolation.rb
#
# 各Boxが独立した $LOAD_PATH や グローバル変数を持てることを確認する。
# 実際のユースケース: テストの隔離、異なる設定の並行評価など。

puts "=== グローバル変数の隔離 ==="
puts

$app_mode = "production"
puts "メイン: $app_mode = #{$app_mode}"

box1 = Ruby::Box.new
box2 = Ruby::Box.new

box1.eval(<<~RUBY)
  $app_mode = "staging"
  puts "Box1: $app_mode = \#{$app_mode}"
RUBY

box2.eval(<<~RUBY)
  $app_mode = "development"
  puts "Box2: $app_mode = \#{$app_mode}"
RUBY

puts "メイン: $app_mode = #{$app_mode}"
puts
puts "→ 各Boxで $app_mode が独立している"
puts

puts "=== LOAD_PATH の隔離 ==="
puts
puts "メインの $LOAD_PATH エントリ数: #{$LOAD_PATH.size}"

box = Ruby::Box.new
box.eval(<<~RUBY)
  puts "Boxの $LOAD_PATH エントリ数: \#{$LOAD_PATH.size}"
  $LOAD_PATH << "/tmp/my_box_lib"
  puts "追加後: \#{$LOAD_PATH.size}"
RUBY

puts "メインの $LOAD_PATH エントリ数: #{$LOAD_PATH.size}"
puts
puts "→ Boxに追加したパスは、メインには影響しない"
puts

puts "=== ユースケースまとめ ==="
puts
puts "1. テストの隔離: 各テストが互いに影響しない"
puts "2. gemの評価: 新バージョンをBoxで試して、既存コードに影響しないか確認"
puts "3. プラグインシステム: プラグインのコードをBoxに閉じ込める"
