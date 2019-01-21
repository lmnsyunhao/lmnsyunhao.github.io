{### LeanCloud Setting ###}
<script src="//cdn.jsdelivr.net/npm/leancloud-storage@3.11.1/dist/av-min.js"></script>
<script>
  AV.init({
    appId: "{{ theme.leancloud_visitors.app_id }}",
    appKey: "{{ theme.leancloud_visitors.app_key }}"
  });

  var loadcomponent = function(componentname, callback){
    query = new AV.Query('Key');
    query.equalTo("AppName", componentname);
    query.find().then(function (results) {
      callback(results[0].attributes);
    }, function (error) {
    });
  }
</script>

{### DaoVoice Setting ###}
{% if config.daovoice %}
  <script>
    var loaddaovoice = function(data){
      daovoiceappid = data.AppKey;
      (function(i,s,o,g,r,a,m){i["DaoVoiceObject"]=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;a.charset="utf-8";m.parentNode.insertBefore(a,m)})(window,document,"script",('https:' == document.location.protocol ? 'https:' : 'http:') + "//widget.daovoice.io/widget/"+daovoiceappid+".js","daovoice")
      daovoice('init', {
          app_id: daovoiceappid
        });
      daovoice('update');
    }
  </script>
{% endif %}

{### Gitalk Setting ###}
{% if page.comments and config.gitalk.enable %}
  <link rel="stylesheet" href="{{ theme.vendors.gitalk_css }}">
  <script src="{{ theme.vendors.gitalk_js }}"></script>
  <script src="{{ theme.vendors.md5 }}"></script>
  <script>
    var loadgitalk = function(data){
      var gitalkclientidgithubstream=data.AppID;
      var gitalksecretgithubstream=data.AppKey;
      var gitalk = new Gitalk({
        clientID: gitalkclientidgithubstream,
        clientSecret: gitalksecretgithubstream,
        repo: '{{ config.gitalk.repo }}',
        owner: '{{ config.gitalk.owner }}',
        admin: '{{ config.gitalk.admin }}',
        id: md5(location.pathname),
        distractionFreeMode: 'true'
      });
      var div = document.createElement('div');
      div.setAttribute("id", "gitalk_comments");
      div.setAttribute("class", "post-nav");
      var bro = document.getElementById('posts').getElementsByTagName('article');
      bro = bro[0].getElementsByClassName('post-block');
      bro = bro[0].getElementsByTagName('footer');
      bro = bro[0];
      bro.appendChild(div);
      gitalk.render('gitalk_comments');
    }
  </script>
{% endif %}

{### Header Font Setting ###}
<style type="text/css">
  @font-face {
    font-family: SignaritaZhaiRhianne;
    src: url("/fonts/signarita_zhai_rhianne-webfont.ttf")
  }
  @font-face {
    font-family: SignaritaZhaiRhianne;
    src: url("/fonts/signarita_zhai_rhianne-webfont.woff")
  }
  @font-face {
    font-family: SignaritaZhaiRhianne;
    src: url("/fonts/signarita_zhai_rhianne-webfont.woff2")
  }
</style>
<script>
  var ele = document.getElementById('header').getElementsByClassName('header-inner');
  ele = ele[0].getElementsByClassName('site-brand-wrapper');
  ele = ele[0].getElementsByClassName('site-meta');
  ele = ele[0].getElementsByClassName('custom-logo-site-title');
  ele = ele[0].getElementsByClassName('brand');
  ele = ele[0].getElementsByClassName('site-title');
  ele[0].style.paddingTop = "15px";
</script>

{### Images Src Redirection ###}
<script>
  imgele = document.getElementsByTagName('img');
  i = 0;
  while(imgele[i]){
    imgsrc = imgele[i].getAttribute('src');
    domainIdx = imgsrc.indexOf('images.yunhao.space/pic');
    if(domainIdx != -1){
      picset = imgsrc.substr(domainIdx+23, 1);
      picname = imgsrc.substr(domainIdx+24);
      targeturl = "https://raw.githubusercontent.com/lmnsyunhao/blog-pic"+picset+"/master"+picname;
      imgele[i].setAttribute("src",targeturl);
    }
    i++;
  }
</script>

{### Load Component ###}
<script>
  {% if config.daovoice %}
    loadcomponent("daovoice", loaddaovoice);
  {% endif %}
  {% if page.comments and config.gitalk.enable %}
    loadcomponent("gitalk", loadgitalk);
  {% endif %}
</script>