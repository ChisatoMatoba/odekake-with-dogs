if defined?(Bullet)
  Bullet.enable = true  # Bulletプラグインを有効にする
  Bullet.alert = true  # ブラウザのJavaScriptアラートで通知
  Bullet.bullet_logger = true  # Railsのログに記録する
  Bullet.console = true  # ブラウザのコンソールログに記録する
  Bullet.rails_logger = true  # Railsのログに出力する
  Bullet.add_footer = true  # ブラウザのフッタに通知を追加する
end
