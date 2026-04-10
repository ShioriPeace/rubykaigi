# Step 4: 自分のコードを解析する
#
# 実行方法:
#   ruby 04_analyze.rb 04_analyze.rb     ← 自分自身を解析
#   ruby 04_analyze.rb ../cruby/04_gc.rb ← 他のファイルも解析できる
#
# RuboCopがやってることの超簡易版。

require 'prism'

file = ARGV[0]
unless file
  puts "使い方: ruby 04_analyze.rb <ファイル名>"
  exit 1
end

unless File.exist?(file)
  puts "ファイルが見つからない: #{file}"
  exit 1
end

source = File.read(file)
result = Prism.parse(source)

puts "=== #{file} の解析結果 ==="
puts

# ノードを再帰的に集める
def collect_nodes(node, type, &block)
  found = []
  if node.is_a?(type)
    found << node
  end
  node.child_nodes.compact.each do |child|
    found.concat(collect_nodes(child, type))
  end
  found
end

# メソッド定義を探す
methods = collect_nodes(result.value, Prism::DefNode)
puts "メソッド定義: #{methods.size}個"
methods.each do |m|
  params = m.parameters&.parameters&.size || 0
  puts "  - #{m.name}（引数#{params}個, #{m.location.start_line}行目）"
end
puts

# 文字列リテラルを探す
strings = collect_nodes(result.value, Prism::StringNode)
puts "文字列リテラル: #{strings.size}個"
strings.first(5).each do |s|
  content = s.content.length > 30 ? s.content[0..30] + "..." : s.content
  puts "  - \"#{content}\"（#{s.location.start_line}行目）"
end
puts "  ...他 #{strings.size - 5}個" if strings.size > 5
puts

# クラス定義を探す
classes = collect_nodes(result.value, Prism::ClassNode)
puts "クラス定義: #{classes.size}個"
classes.each do |c|
  puts "  - #{c.name}（#{c.location.start_line}行目）"
end
puts

# 行数
lines = source.lines.size
comment_lines = source.lines.count { |l| l.strip.start_with?("#") }
blank_lines = source.lines.count { |l| l.strip.empty? }
code_lines = lines - comment_lines - blank_lines

puts "行数: 全#{lines}行（コード#{code_lines} / コメント#{comment_lines} / 空行#{blank_lines}）"
puts
puts "→ RuboCopもこんな感じでASTを解析して、ルール違反を見つけてる"
