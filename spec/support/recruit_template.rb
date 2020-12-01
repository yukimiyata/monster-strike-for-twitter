module RecruitTemplate
  def recruit_page_and_put_template
    click_on 'recruit-image-link'
    fill_in 'input-quest-body', with: 'モンストでマルチしない？
「test-quest」
https://static.monster-strike.com/line/?pass_code=text-code
↑このURLをタップすると、タップした人達同士で一緒にマルチプレイができるよ！

https://static.monster-strike.com/i/?i=
↑モンストをまだ始めていなかったらこのURLからインストールしてね！
'
  end
end