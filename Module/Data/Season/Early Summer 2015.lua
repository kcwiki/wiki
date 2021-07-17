--Categories:
--[[Category:Seasonal modules]]

return {
  index = {
    ["Destroyers"] = { "Kisaragi", "Fumizuki", "Shirayuki", "Oboro", "Akebono", "Sazanami", "Ushio", "Shiratsuyu", "Shigure", "Murasame", "Yuudachi", "Kagerou", "Shiranui", "Hatsukaze", "Tokitsukaze", "Maikaze", "Takanami" },
    ["Light Cruisers"] = { "Tatsuta", "Ooi", "Yura", "Kinu", "Abukuma", "Sendai", "Naka", "Yuubari" },
    ["Heavy Cruisers"] = { "Furutaka", "Kako", "Nachi", "Ashigara", "Choukai", "Suzuya", "Kumano", "Tone", "Chikuma" },
    ["Battleships"] = { "Fusou", "Yamashiro", "Hyuuga", "Nagato", "Mutsu", "Littorio", "Roma" },
    ["Light Carriers"] = { "Shouhou" },
    ["Standard Carriers"] = { "Akagi", "Kaga", "Shoukaku", "Zuikaku" },
    ["Submarines"] = { "Ro-500" },
    ["Auxiliaries"] = { "Katori", "Akitsushima", "Akashi" },
  },
  ships = {
    ["Kisaragi"] = {
      {
        ja = "もうすぐ夏ねぇ～。新しい水着、買っちゃおう…かな？…ねぇ、どれがいいと思う？",
        en = "It'll be summer soon~. Maybe I should go buy a new swimsuit.... Hey, which one do you think is good~?",
      },
    },
    ["Fumizuki"] = {
      {
        ja = "そろそろ夏！気の早い蝉がもう泣いてる。",
        en = "Summer's soon! Those impatient cicadas have already started chirping~.",
      },
    },
    ["Shirayuki"] = {
      {
        ja = "ううん…この季節、飛び交う虫は苦手です。ぐるぐる型のお香を焚きましょ！白雪にお任せください！一網打尽です！",
        en = "Ugh, I don't like flying insects this season. Let's burn a swirly-type incense! Leave it to Shirayuki to handle the big task!",
        note = "'swirly-type incense' refers to coil-based anti-mosquito smoke repellent<sup>[http://neko3nanodesu.seesaa.net/article/421747538.html]</sup>.",
      },
    },
    ["Oboro"] = {
      {
        ja = "提督。いよいよサマーシーズン到来ですね。第七駆逐隊、夏季演習準備、ばっちりです。",
        en = "Admiral. The summer season is finally here! The Seventh Destroyer Division is fully prepared for the summer season practice!",
      },
      {
        ja = "え？このカニですか？はい、元気です！",
        en = "Hm? This crab? Yes, she's doing well.",
        line = "Secretary 2",
      },
      {
        ja = "夏の戦い、いよいよですね！第七駆逐隊、夏は張り切って参ります。",
        en = "It's finally time for some summer battles! The Seventh Destroyer Division will give it our all.",
        line = "Joining A Fleet",
      },
      {
        ja = "くっ……せっかくの水着が……。大丈夫、お風呂入れば治ります……た、多分……。",
        en = "Ah....I finally got to wear my swimsuit & this.... It's alright, it'll be fixed if I take a bath.... P-probably.",
        line = "Docking Major",
      },
    },
    ["Akebono"] = {
      {
        ja = "熱くなってきたから、確かにこの格好はすごしやすいけど…く、クソ提督！こっち見んな！",
        en = "It's gotten hot, it's true that this outfit is a bit comfy but.... D-Don't look this way, you shitty Admiral!",
      },
      {
        ja = "だから、ジロジロ見るなって！このクソ提督！",
        en = "Like I said, don't stare, you shitty Admiral!",
        line = "Secretary 2",
      },
      {
        ja = "触ったらマジ怒るから、あり得ないから！",
        en = "I'll seriously get angry if you touch me, so don't even think of it!",
        line = "Secretary 3",
      },
      {
        ja = "の、覗くな！このクソ提督！も、もう！",
        en = "D-Don't peek! You shitty Admiral! G-Geez!",
        line = "Docking Major",
      },
    },
    ["Sazanami"] = {
      {
        ja = "夏、キタコレ！まだ早いって？いいの、いいの！早いくらいがいいんだって!",
        en = "Summer's finally here! It's still early? Whatever! It's fine! A bit early is better, you know!",
      },
      {
        ja = "え？漣のこの水着、いいっしょいいっしょ？フフーン！もっと見てもいいよ？",
        en = "Hm? Sazanami's swimsuit is pretty good, ain't it? Hm-hmm! You can look more if you want!",
        line = "Secretary 3",
      },
      {
        ja = "あ～もう！　せっかくの水着が台無しじゃん！　なえ～　漣はお風呂入ってくるから！",
        en = "Ah~ geez! My swimsuit's all messed up! That's totally lame~. Sazanami's gonna take a bath!",
        note = "Netslang<sup>[http://lineq.jp/q/1751521]</sup>",
        line = "Docking Major",
      },
    },
    ["Ushio"] = {
      {
        ja = "水着は…少し恥ずかしいです。あの…提督、もし駄目だったら言ってくださいね！",
        en = "Wearing a swimsuit is....a bit embarrassing. Um.... Admiral, if this is no good, please tell me!",
      },
      {
        ja = "ひゃあっ！……あ……あの……びっくりしますから……",
        en = "Hiaa! ....Ah.... Um.... That scares me so....",
        line = "Secretary 2",
      },
      {
        ja = "あの……やはり、いつもの恰好に戻った方が、良いですよね……？あの……すいません！",
        en = "Um.... It would be better if I went back to wearing my usual clothes, wouldn't it...? Um.... Sorry!",
        line = "Secretary 3",
      },
      {
        ja = "すみません……あまり、こちらを見ないで……",
        en = "Sorry.... Don't look this way so much....",
        line = "Docking Major",
      },
    },
    ["Shiratsuyu"] = {
      {
        ja = "梅雨が明ければ夏だよね。海開きでは一番に泳ぎたいな。ね！",
        en = "When the rainy season's done, it's summer. I want to be the first one to swim when the beach opens. Yeah!",
      },
      {
        ja = "うん！夏は夏で盛り上がらないと！提督も一緒に浜辺に行こうよ！にしししし。",
        en = "Right! Summer has its own excitements! Let's go to the beach together, Admiral! Ehehehehe.",
        line = "Secretary 2",
      },
      {
        ja = "あ、これ？　いやぁ、浜辺での夏季特別演習に必要って……長門さんが。ちょっと早いけど……",
        en = "Ah, this? Nah, it's needed for some special summer training on the beach....Nagato-san said. It's a little early for this though....",
        line = "Secretary 3",
      },
      {
        ja = "ええ？！　肌、焼けてる？　まじ？　しまった、オイル塗るの忘れてた...　やばい！",
        en = "Eh?! I got sunburnt? Seriously? Oh no, I forgot to apply the cream.... Crap!",
        line = "Joining A Fleet",
      },
      {
        ja = "だぁ～……いっちばんお気に入りの水着なのに……許すまじ……お風呂に直行だぁーっ!",
        en = "Dah~ ....And that was my favourite swimsuit.... Unforgivable.... Straight to the baths I go!",
        line = "Docking Major",
      },
    },
    ["Shigure"] = {
      {
        ja = "もうすぐ今年も夏が来るね。水着？ああ、去年のがあるから僕は大丈夫。",
        en = "Summer's closing in this year, too. Swimsuit? Oh, I have last year's so I'm fine.",
      },
    },
    ["Murasame"] = {
      {
        ja = "そろそろ夏が来ちゃうね。新しい水着、新調したいな。一緒に選らんでくれる？",
        en = "Summer is around the corner. I want to get myself a new swimsuit. Want to help me pick one?",
      },
      {
        ja = "提督、どう？村雨の水着似合ってる？そう？いい感じいい感じ。",
        en = "Admiral, how is it? Does Murasame look good in this swimsuit? Really? Good, good.",
        line = "Secretary 2",
      },
      {
        ja = "村雨のちょっと良い水着見せてあげる。じゃん！提督どうかしらね？",
        en = "Murasame will show you some of her better swimsuits. Tada! How do I look, Admiral?",
        line = "Joining A Fleet",
      },
      {
        ja = "やられてしまったわ……せっかくの水着だったのに……。ま、いいわ。お風呂してきますね。",
        en = "They got me.... I just got to wear that swimsuit, too.... Well, that's alright. I'm going to take a bath.",
        line = "Docking Major",
      },
    },
    ["Yuudachi"] = {
      {
        ja = "少しずつ熱くなってきたっぽい。今年も夏来るっぽい！",
        en = "It's, like, gotten hotter bit by bit poi. Like, summer is coming this year, too!",
      },
    },
    ["Kagerou"] = {
      {
        ja = "不知火～、あんたも今年は新しい水着買いなさいよ。ふえ？ああ、もう！私が選んであげる！",
        en = "Shiranui~! You, too, should buy a new swimsuit this year. Eh? Aah, sheesh! I'll choose for you!",
      },
    },
    ["Shiranui"] = {
      {
        ja = "いや。不知火はそんな買い物にはいかな-…いや、仕方ない。あ、これはいいかも。",
        en = "No. Shiranui will not buy such a.... Fine. No way around it. Ah, this might work.",
      },
    },
    ["Hatsukaze"] = {
      {
        ja = "ふう…もうすぐ夏ね。え、水着？買ってないわ。なーに？プレゼントしてくれるの？",
        en = "Haahh.... Ah, it'll be summer soon.... Eh? A swimsuit? I didn't buy one. What's that? You want to give me a present?",
      },
    },
    ["Tokitsukaze"] = {
      {
        ja = "しれー、そろそろ夏だね。今年の夏は雪風たちと泳ぎに行こうよ。ねー、ねーー！",
        en = "Commanderrrr! It's almost summertime! Let's go swimming with Yukikaze this summer. Okay? Okayyyy????",
      },
    },
    ["Maikaze"] = {
      {
        ja = "もうすぐ夏ですね、提督。夏はどんなステップで踊る？ふーん、どうしよっか。ねえ、提督？",
        en = "It's going to be summer soon, huh, Admiral? What dance should I dance for summer? Hmm, what should I do... Admiral, what do you think?",
      },
    },
    ["Takanami"] = {
      {
        ja = "熱くなって来ましたね。もうすぐ夏かも。司令官は熱くないかもですか？",
        en = "It's gotten hot, isn't it? Maybe it will be summer soon. Might the Commander not be feeling hot?",
      },
    },
    ["Tatsuta"] = {
      {
        ja = "今年も暑くなるわね。執務室にクーラーですって？何をふざけているのかしら？その服を…涼しくしてあげましょうね。",
        en = "This year has become hot, hasn't it? To desire having an air conditioner in the office? I wonder what are you joking about? Those clothes of yours... I'll make them cooler for you, yeah?",
      },
    },
    ["Ooi"] = {
      {
        ja = "もうすぐ夏ね！北上さんとお揃い水着買わなくちゃ、うふうふうふふふ。",
        en = "Summer is close, isn't it? Got to go buy a matching set of swimsuits with Kitakami. Ufufufufufu.",
      },
    },
    ["Yura"] = {
      {
        ja = "提督さん。梅雨が終わると夏の気配、感じますね。ね？由良も水着…欲しいな。",
        en = "Admiral. You can feel the summer when the rainy season ends. Right? Yura would like....a new swimsuit, too.",
      },
    },
    ["Kinu"] = {
      {
        ja = "あっついな。もう夏か。しょっか。ミーンミーンミーン。うん？あっ、駄目？",
        en = "So hot.... So it's already summer.... Summaht. (buzzing cicada sounds) Huh? That's no good?",
        note = "ミーン (mi-n) is basically the buzzing sound of cicada during summer.<br>しょっか is intended to be a pun with 初夏 meaning 'Early Summer'",
      },
    },
    ["Abukuma"] = {
      {
        ja = "日の入りがずいぶんと長くなりましたね。もうすぐ夏ですね。ふうー…そうなるとどこかの三水戦のがうるさくなるな。",
        en = "It sure is taking longer for the sun to set, isn't it? Looks like summer is right around the corner. Haahh ....And when it's here, those girls from the Third Torpedo Squadron will be a whole lot noisier.",
        note = "[http://dic.pixiv.net/a/%E4%B8%89%E6%B0%B4%E6%88%A6%E3%83%88%E3%83%AA%E3%82%AA 三水戦 (via pixiv)] refers to 3rd Torpedo Squadron in Kancolle Anime.",
      },
    },
    ["Sendai"] = {
      {
        ja = "夏だ！やった！夜戦の季節だ！提督、夜戦だよ、夜戦！早くやーせーん！",
        en = "Summertime! Hurray! The season for night battles! Admiral, let's do some night battles! Hurry & start a night-bat-tle!",
      },
    },
    ["Naka"] = {
      {
        ja = "夏だよ、夏！那珂ちゃんサマーライブの夏だよ！よーし、歌うよ！衣装、衣装！",
        en = "It's summer! Summer! The summer of Naka-chan's summer concert! Alright, I'm gonna sing! My costume! My costume!",
      },
    },
    ["Yuubari"] = {
      {
        ja = "はうー。少し暑くなってきたわね。今年も夏が来るのか。早いなー。",
        en = "Ahh.... It's gotten a bit hot, hasn't it? It seems summer has come this year as well. That was fast, hmm.",
      },
    },
    ["Furutaka"] = {
      {
        ja = "今年も夏がやってきますね。新しい水着、加古と買いに行こうかな。",
        en = "This year's summer has come along, hasn't it? I wonder where I should buy a new swimsuit with Kako.",
      },
    },
    ["Kako"] = {
      {
        ja = "いよいよ暑くなってきましたね。夏が来るね。いひひ。いいね、夏！いいよ！",
        en = "Finally, it has become hot weather, hasn't it? Summer is coming, isn't it? Ehehehe. Good. Summer. Excellent!",
      },
    },
    ["Nachi"] = {
      {
        ja = "夏だな。暑いがまあ、気になるほどではないな。さぁ、暑気払いで一本やるか！",
        en = "Summer, isn't it? It's a bit hot, but it isn't unbearable. Well, why don't we open a bottle to rid of the heat!",
        note = "To elaborate, the last sentence is on drinking. 一本 means one bottle, and is often colloquially used to signify a bottle of liquor. (As we all know of Nachi's love for alcohol)",
      },
    },
    ["Ashigara"] = {
      {
        ja = "今年も夏が近づいてきたわね。何だかみなぎってきたわ。行ける！今年はいけるわ！",
        en = "This year's summer is approaching, isn't it? I'm somewhat pumped up. This year is a goer!",
      },
    },
    ["Choukai"] = {
      {
        ja = "夏ですね。えっ！？水着ですか？い、いいえ。私はそのような… あ… はい… では、今度…",
        en = "Summer, isn't it? Eh!? Swimsuit? Uhh, no. For me things like that are... ah... Yes... Then, next time...",
      },
    },
    ["Suzuya"] = {
      {
        ja = "うーん。ちょっち暑くなってきたかな。うう、何かむしむしする。熊野は平気？",
        en = "Argh. It's gotten pretty hot. Ugh, it's all hot & humid. Kumano, you don't mind it?",
      },
    },
    ["Kumano"] = {
      {
        ja = "夏の足音を感じますわ！鈴谷、わたくし、最新の水着を買いにいきたいですわ。",
        en = "I can feel summer's footsteps! Suzuya, I want to go out & buy the latest swimsuits.",
      },
    },
    ["Tone"] = {
      {
        ja = "ああ～　熱くなってきたのじゃ。熱いのは苦手じゃ。筑摩。筑摩～！アイス…ラムネ…",
        en = "Ugh.... It's getting hot. I'm no good with heat. Chikuma. Chikuma~! Ice cream.... Lemonade....",
      },
    },
    ["Chikuma"] = {
      {
        ja = "日差しが強くなってきたわ。お肌がピンチね。利根姉さんにも日焼け止めを塗ってあげなきゃ。利根姉さん？",
        en = "The sunshine has gotten stronger. It will be trouble for the skin. I should put some sunscreen on Tone-neesan too. Tone-neesan?",
      },
    },
    ["Fusou"] = {
      {
        ja = "山城？もうすぐ夏ね。扶桑型姉妹でたまにはどこかに行く？どこがいいかしら。",
        en = "Yamashiro? It's going to be summer soon. Do you want to go somewhere together? I wonder where would be nice.",
        note = "For simplicity, 'Fusou-class sisters' was edited to 'together'.",
      },
    },
    ["Yamashiro"] = {
      {
        ja = "姉さま。旅行の計画ですか？いいと思います！山城、姉さまと一緒ならどこでも…！",
        en = "Onee-sama, are you planning for a trip? I think it's a wonderful idea! Yamashiro is fine with anywhere as long as it's with you...!",
      },
    },
    ["Hyuuga"] = {
      {
        ja = "この季節は嫌いではないな。伊勢…伊勢？何だ。寝てるのか。",
        en = "I don't hate this season. Ise.... Ise? Ah, you're sleeping?",
      },
    },
    ["Nagato"] = {
      {
        ja = "善しっ、夏だな。艦隊、水着で浜辺に集合だ！　演習、”ビーチバレー”というのをやるぞ！　チーム分けはこの長門が考えておいた！",
        en = "Okay, it's summer time! Assemble with your swimsuits at the beach, fleet! We're going to practice 'beach volleyball'! I, Nagato, have already set the teams!",
      },
    },
    ["Mutsu"] = {
      {
        ja = "何、長門ったら… ビーチバレー？いいけど、あなたルール知ってるの？あらあら、仕方ないわね。任せて。",
        en = "What is it, Nagato? Beach volleyball? That's okay but.... Do you know the rules? My, my, it can't be helped. Leave it to me!",
      },
    },
    ["Littorio"] = {
      {
        ja = "もうすぐ夏ですね、提督。新しい水着を試してみたいですね。くすくす。楽しみです！",
        en = "It's finally summertime, Admiral. I want to try out a new swimsuit. Heh heh, it's fun, isn't it?",
      },
    },
    ["Roma"] = {
      {
        ja = "大分暑くなってきたけれど…もうすぐ夏か。姉さん、水着新調したんだ。ふーん。",
        en = "Even though it has become considerably hot.... Summer is soon. Neesan, I want to buy a new swimsuit. Hmm.",
      },
    },
    ["Shouhou"] = {
      {
        ja = "夏はこの格好だとちょうどいいんです、提督。冬は寒くないのかって？そ、そうですね。い、いいえ！大丈夫です！",
        en = "For summer, this clothing suits perfectly, Admiral. Isn't it cold during the winter, you say? W-well. N-no! It's fine!",
      },
    },
    ["Akagi"] = {
      {
        ja = "あら、加賀さん。もうすぐ夏ね。え？新しい水着ですか。特に用意してないけれど…",
        en = "Oh, Kaga-san. Summer is coming. Eh? A new swimsuit? I had not thought about preparing that....",
      },
    },
    ["Kaga"] = {
      {
        ja = "夏はあまり好きではないわ。海？いってらっしゃい。",
        en = "I am not too fond of the summer. The sea? Have fun.",
      },
    },
    ["Shoukaku"] = {
      {
        ja = "瑞鶴、新しい水着を買ったの？あら、いいわね。とても可愛いわ。え？私？私は去年のでいいわ。えっ、そう？そうかしら。",
        en = "Zuikaku, did you buy a new swimsuit? My, it is nice. It's very cute. Eh? Me? I'm fine with last year's. Wha, really? Do you think so?",
      },
    },
    ["Zuikaku"] = {
      {
        ja = "翔鶴姉、見てみて！今年のおニューの水着だよ！買っちゃった！だって、もうすぐ夏だよ、夏！翔鶴姉も買いに行こうよ！",
        en = "Shoukaku-nee, look, look! It's my brand new swimsuit for this year! I went & bought it! I mean, it is almost summer! You should come with me & buy one, too!",
      },
    },
    ["Ro-500"] = {
      {
        ja = "熱くなって来た。提督！提督も水着になるって。見たいって！",
        en = "It's gotten hot. Admiral! Admiral should a wear swimsuit, too. I want to see it!",
      },
    },
    ["Katori"] = {
      {
        ja = "また、夏がやってきましたね。駆逐艦たちがはしゃいでる。提督、一泳ぎします？",
        en = "Summer has come again, hasn't it? The destroyers are really excited. Admiral, how about a swim?",
      },
    },
    ["Akitsushima"] = {
      {
        ja = "おーい！もうすぐ夏が来るかも！大艇ちゃんと一緒に泳ぎに行かなきゃ。提督も行くでしょ？楽しみかも！",
        en = "Hey! It's maybe almost summer! I have to swim with Taitei-chan! You're coming too, right, Admiral? I might be looking forward to it!",
      },
    },
    ["Akashi"] = {
      {
        ja = "夏ですね！私もおしゃれな水着ほしいなー。提督！買ってくれてもいいのよ！きらきら！えへへー。",
        en = "It's summer,isn't it? I, too, would want to dress in a swimsuit~. Admiral, you can buy me one! (sparkle)! Ehehe.",
        note = "きらきら (kira kira) literally means sparkling, but it is also net slang for other things.<br><p>",
      },
    },
  },
}