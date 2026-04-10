# Parser: Rubyのコードの構造を覗く

`puts "hello"` と書いたとき、Rubyはまずこの文字列を「解析（パース）」して
**木の形（AST = 抽象構文木）** に変換する。

CRubyのチュートリアルで見た流れの最初のステップ:

```
コード → ① パース → ② AST → バイトコード → 実行
              ↑
            ここを見る！
```

RuboCopもこの仕組みを使ってる。コードの「構造」を見てルール違反を見つけてる。

---

## Step 0: セットアップ

```bash
cd ~/rubykaigi/parser
rbenv local 4.0.1
ruby --version
```

Ruby 3.4以降は **Prism** というパーサーがデフォルト。
追加インストールは不要。

---

## Step 1: ASTを見てみる（01_first_ast.rb）

一番シンプルなコードのASTを見てみよう。

```bash
ruby 01_first_ast.rb
```

`1 + 2` がどんなツリーになるか。
「足し算」は実は「メソッド呼び出し」だったりする。

---

## Step 2: いろんなコードのASTを比較する（02_various_ast.rb）

変数代入、if文、メソッド定義...
それぞれどんなツリーになるか見てみる。

```bash
ruby 02_various_ast.rb
```

---

## Step 3: Prism でもっと詳しく見る（03_prism.rb）

Ruby 3.4からデフォルトになった **Prism** パーサーを直接使ってみる。
`RubyVM::AbstractSyntaxTree` よりも詳しい情報が見える。

```bash
ruby 03_prism.rb
```

---

## Step 4: 自分のコードを解析する（04_analyze.rb）

ASTを使うと「このファイルにメソッドがいくつあるか」みたいな分析ができる。
RuboCopがやってることの超簡易版。

```bash
ruby 04_analyze.rb 04_analyze.rb
```

自分自身を解析する。好きな .rb ファイルを引数に渡してもOK。

---

## ふりかえり

- **パース** = コードの文字列をツリー構造に変換すること
- **AST（抽象構文木）** = コードの構造を表すツリー
- **Prism** = Ruby 3.4からデフォルトの新しいパーサー（以前はparse.y）
- `RubyVM::AbstractSyntaxTree.parse` や `Prism.parse` でASTが見える
- RuboCopはASTを解析してルール違反を見つけてる
- 「コードの構造を理解する」ことは、良いコードを書く手がかりになる
