# Ruby::Box: クラスやモジュールを隔離する

Ruby 4.0 で入った新機能。笹田耕一（ko1）さんが開発。
もともと「Namespace」と呼ばれていた構想が形になったもの。

**何ができるか:** 1つのRubyプロセスの中で、クラスやモジュールを分離できる。
あるBoxの中でモンキーパッチしても、別のBoxには影響しない。

**なぜ嬉しいか:** gemが内部でモンキーパッチしていても、
自分のコードに影響しないようにできる。テストの隔離にも使える。

⚠️ **実験的機能**: `RUBY_BOX=1` 環境変数で有効にする必要がある。

---

## Step 0: セットアップ

```bash
cd ~/rubykaigi/ruby-box
rbenv local 4.0.1
ruby --version
# ruby 4.0.1 が出ればOK
```

Ruby::Box は実験的機能なので、実行時に環境変数が必要:

```bash
RUBY_BOX=1 ruby -e "puts Ruby::Box"
# Ruby::Box と出ればOK
```

---

## Step 1: Boxの基本（01_basic_box.rb）

Boxを作って、その中と外でクラスの状態が違うことを確認する。

```bash
RUBY_BOX=1 ruby 01_basic_box.rb
```

---

## Step 2: モンキーパッチの隔離（02_monkey_patch.rb）

Rubyでは既存のクラスにメソッドを追加できる（モンキーパッチ）。
でもBoxを使うと、パッチの影響を隔離できる。

```bash
RUBY_BOX=1 ruby 02_monkey_patch.rb
```

---

## Step 3: gemの隔離（03_gem_isolation.rb）

異なるBoxで異なるバージョンの設定を持てることを確認する。

```bash
RUBY_BOX=1 ruby 03_gem_isolation.rb
```

---

## ふりかえり

- **Ruby::Box** = Ruby 4.0 の新機能。クラス・モジュール・定数を隔離する
- もともと「Namespace」と呼ばれていた構想
- 各Boxは独立した `$LOAD_PATH`、`$LOADED_FEATURES` を持つ
- モンキーパッチの影響を閉じ込められる
- まだ実験的機能（`RUBY_BOX=1` が必要）
- 開発者: 笹田耕一（ko1）さん
