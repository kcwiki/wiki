--Categories:
--[[Category:Seasonal modules]]

return {
  index = {
    ["Destroyers"] = { "Akebono", "Hatsuharu", "Shigure", "Yuudachi", "Yayoi", "Uzuki", "Asagumo", "Yamagumo", "Murasame" },
    ["Light Cruisers"] = { "Abukuma" },
    ["Heavy Cruisers"] = { "Nachi", "Ashigara", "Mogami" },
    ["Battleships"] = { "Fusou", "Yamashiro" },
    ["Standard Carriers"] = { "Ark Royal" },
    ["Submarines"] = { "I-26" },
    ["Auxiliaries"] = { "Commandant Teste" },
  },
  ships = {
    ["Akebono"] = {
      {
        ja = "うん、泣いても笑っても決戦ってわけか！あたしも本気で行くから、クソ提督、行くよ！",
        en = "Hmph, so the final battle is inevitable, huh? I've gotta get serious, too! Let's go, you shitty Admiral!",
      },
    },
    ["Hatsuharu"] = {
      {
        ja = "なんじゃ、その・・・わらわも貴様を信頼している・・・ぞ。うん・・・まあ、そういうことじゃ！",
        en = "Well, I mean, I trust you.... Yeah, well, that's all!",
        note = "For once it appears she isn't using her archaic speech.",
      },
    },
    ["Shigure"] = {
      {
        ja = "この季節は... ううん、提督、いい雨だね。",
        en = "This season is... no, it's a nice rain, Admiral.",
        note = "PTSD kicking in.",
      },
      {
        ja = "満潮、そうか... よかったね。一緒に準備をしよう。うん。",
        en = "Michishio... I see, that's good. Let's get ready together. Yeah.",
        line = "Secretary 2",
      },
      {
        ja = "扶桑、 山城、気をつけて。 大部隊だけど、油断は全然出来ないんだ。僕も…僕も全力で守るから！",
        en = "Fuso, Yamashiro. . . Be careful . Although it is a big force, we can't be careless. I will also protect you with all my strength!",
        note = "November 10th line",
        line = "Secretary 3",
      },
    },
    ["Yuudachi"] = {
      {
        ja = "皆、戦いの準備をしてるっぽい？夜戦の準備っぽい？",
        en = "You're all getting ready for battle, poi? Night battle preparations, poi?",
        note = "The real-life Yuudachi sank during the Guadalcanal Campaign, which occurred one year before the battle of Leyte Gulf.",
      },
    },
    ["Yayoi"] = {
      {
        ja = "卯月、あの・・・この季節は、気を付けて。あの・・・怒ってなんか・・・ないけど・・・気を、付けてね",
        en = "Uzuki. Ummm, be careful during this season. Ummm, I'm not angry. Yeah, be careful, alright?",
      },
    },
    ["Uzuki"] = {
      {
        ja = "弥生？何を心配そうな顔をしてるぴょん！なんか怒ってるぴょん？大丈夫ぴょん！卯月は不沈艦ぴょん！沈まないぴょん！",
        en = "Yayoi? Why are you frowning, pyon? Are you angry about something, pyon? It's fine, pyon! I'm unsinkable, pyon. I won't sink, pyon!",
        note = "Uzuki stealing Yukikaze's lines.",
      },
    },
    ["Asagumo"] = {
      {
        ja = "ん、そうか。今年もこの季節はやって来たのか。夜でも・・・大丈夫。私は・・・大丈夫！",
        en = "Yeah, I see. So this season has come again this year. I'm fine with the night. I'm just fine.",
      },
    },
    ["Yamagumo"] = {
      {
        ja = "この季節がまた・・・やって来たのね～。深夜は少しさわさわします～。うぅ",
        en = "So this season has come again, huh~ The late night is a bit noisy~ Whew~",
      },
    },
    ["Murasame"] = {
      {
        ja = "時雨ちゃん どうしたの？ なるほど。でも、きっと平気。 私達の、佐世保の時雨なら、村雨は信じてます。",
        en = "Shigure-chan, what's wrong? I see. But surely it's alright, If it's our \"Shigure from Sasebo\", Murasame believes.",
        line = "Secretary 3",
      },
    },
    ["Abukuma"] = {
      {
        ja = "よ～し！決戦の時です。一水戦旗艦の経験と自負は、伊達じゃないんです！旗艦、先頭！皆、ついてきて！",
        en = "Alriiiight! It's time for the final battle. My experience and pride as flagship of DesRon1 isn't just for show! Flagship starting battle! Follow me, everyone!",
      },
    },
    ["Nachi"] = {
      {
        ja = "よ～し！いよいよこの那智型・・・違う、妙高型の真の力を見せる時が来たな。やるぞ！",
        en = "Alright! It's finally time for me to show you the Nachi-class'- no, wait, the Myoukou-class' true power. Let's do this!",
        note = "Could be confusing the class names since although Myoukou was the first to be laid down, Nachi was the first one commissioned to the IJN.",
      },
    },
    ["Ashigara"] = {
      {
        ja = "この飢えた狼と言われた足柄、大事な戦いの予感を感じるわ！全力出撃、用意！",
        en = "As someone known as the \"Hungry Wolf\", I feel that this will be an important battle! Let's sortie with all our might!",
        note = "KATSUUUUUUUUUUU",
      },
    },
    ["Mogami"] = {
      {
        ja = "決戦か。 また 突入だね？ 良いよ。 突破しよう！",
        en = "Decisive battle huh. It's a pursuit again, is not it? Alright, lets break through!",
      },
    },
    ["Fusou"] = {
      {
        ja = "時雨、大丈夫よ。私達、第三部隊、七隻。一緒にスリガオ海峡を抜けましょう。今度こそ…。",
        en = "Shigure, it's alright. We, the 3th Force, all seven ships. Together let's go through the Surigao Strait. this time…",
        line = "Secretary 3",
      },
    },
    ["Yamashiro"] = {
      {
        ja = "姉さま？うん？満潮？ああ、そうね。小さいのは任せたわ。え？ふふっ、生意気ね…。姉さまを…守ってね…。",
        en = "Sister? Yes? Michishio? Ah, that's right. I'll let you the small things. Huh? Hehe hee, impertinent, right?. Please Protect... my sister.",
        line = "Secretary 3",
        note = "Probably she talks about PT Imp Pack.",
      },
    },
    ["Ark Royal"] = {
      {
        ja = "この季節は気を付けないと・・・特に潜水艦には要注意だ。まぁ、取り越し苦労ならよいのだが...おっ！右舷に潜望鏡を！回避！・・・ん？ん～？波の見間違いか。ふぅ・・・",
        en = "You need to be careful during this season, especially being careful about submarines. Well, being paranoid is fine but... Hmm? Periscope to starboard! Evasive manoeuvres! ...Hmm? ...Hmmm? That was a wave? *sigh*",
        note = "Ark Royal was sunk by the submarine U-81, hence her paranoia. The 'Periscope to starboard' line could be a reference to the fact that Ark Royal was hit by U-81's torpedoes on her starboard side.",
      },
    },
    ["I-26"] = {
      {
        ja = "あっ！西村艦隊の皆だ！やっほ～～！ね～ね～ね～、どこ行くの～？え？ええぇ！？嘘！？本当に？んん～、来年にしない？",
        en = "Ah, it's the Nishimura Fleet! Yoohoo! Hey, hey, hey, where are you going? Eh? Eeeeh? Seriously? Mmm, why not put it off till next year?",
        note = "I-26 was operating (and sunk) near the area of the Battle of the Surigao Strait, hence her run-in with the Nishimura Fleet. The fleet's destination was (the grave) the US' Army and Marines staging areas to intercept important supplies and bombard land forces.",
      },
    },
    ["Commandant Teste"] = {
      {
        ja = "モガミさん？作戦前の水上機の整備ですか。Oui！ワタクシもお手伝いさせてください。いい機体、ですね！",
        en = "Are you doing pre-operation maintenance on the seaplanes, Mogami-san? Yes, please let me help too. They're good planes.",
      },
    },
  },
}