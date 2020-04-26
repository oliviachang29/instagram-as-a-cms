# 🌄 Instagram as a CMS

See it in action:
* <a href="https://github.com/oliviachang29/rachel-bakery-site" target="_blank">Steely Dan's Lands Repo</a>
* <a href="https://steelydanslands.netlify.app/" target="_blank">Steely Dan's Lands Website</a>

<img src="https://camo.githubusercontent.com/ba06dcdf17b7a7ba01cfcf5c534c66be115182a3/68747470733a2f2f64333377756272666b69306c36382e636c6f756466726f6e742e6e65742f393931653838303634363761336137366466343262333831383735393939376633653764366238622f64313831312f6173736574732f696d616765732f636c69656e742d776f726b2f737465656c792d64616e732d6c616e64734032782e706e67" width="100%">

I'm assuming a Jekyll + Netlify configuration, but most of this is applicable to other static site generators.

## Setting up the Instagram API

### Sign up for a Facebook Developer Account
Follow Facebook's steps [here](https://developers.facebook.com/docs/instagram-basic-display-api/getting-started).

### Generate a user token
Use the [User Token Generator](https://developers.facebook.com/docs/instagram-basic-display-api/overview#user-token-generator) to generate a starting token.

### Use an Instagram token service
Instagram Access tokens last 60 days, then need to be refreshed. Use the [Instagram Token Agent](https://github.com/companionstudio/instagram-token-agent) to automatically refresh tokens.
Deploy the site to Heroku, using the starting token from the previous step.

## Display the Instagram feed

*Call Limit*: Instagram has a limit of 200 calls/hr, so it's easy to exceed the number of calls.

Note: Instagram's Basic Display API only returns the first image of an album.

### Option 1: As a Jekyll Plugin

Copy/paste `jekyllgram.rb` (in this folder) into your `_plugins/` folder. Be sure to replace `@access_token_heroku` with your own Heroku app name.

Access the jekyll feed as `{% jekyllgram %}`. Example:

```html
{% jekyllgram 10 %}
	<a href="{{photo.permalink}}">
		<img src="{{photo.media_url}}" />
	</a>
	<p>{{photo.caption | newline_to_br }}</p>
	<p class="timestamp">{{photo.timestamp | date_to_string }}
{% endjekyllgram %}
```
(use the liquid tag `newline_to_br` to convert `\n` into `<br>` in the caption)

Options:
* `{{photo.permalink}}`: the link to the post
* `{{photo.media_url}}`: the url of the post's image or video
* `{{photo.caption}}`: the caption of the post
* `{{photo.timestamp}}`: the date and time the post was added
* see the rest of the options in `{{photo}}`

This will call the Instagram API every time your site builds.

Credit: `jekyllgram.rb` is based off of https://github.com/benbarber/jekyll-instagram.

### Option 2: Instafeed.js
[Instafeed repo](https://github.com/stevenschobert/instafeed.js)

This will call the Instagram API every time someone accesses your site. Unfortunately, this makes it easy to exceed the API call limit.

## Deploy to Netlify and Use Zapier
Deploy your site to Netlify, then create a Zapier zap so that a new Netlify deploy is created when a new post is added to instagram.

<img src="/images/zapier-instagram-netlify.png" width="100%">

## 💸 Profit
Contributors to this repo are welcome!