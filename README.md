# 🌄 Instagram as a CMS

See it in action:
* <a href="https://github.com/oliviachang29/rachel-bakery-site/settings" target="_blank">Steely Dan's Lands Repo</a>
* <a href="https://steelydanslands.netlify.app/" target="_blank">Steely Dan's Lands Website</a>

I'm assuming a Jekyll + Netlify configuration, but most of this is applicable to other static site generators.

## Setting up the Instagram API

### Sign up for a Facebook Developer Account
Follow Facebook's steps here: https://developers.facebook.com/docs/instagram-basic-display-api/getting-started

### Generate a user token
Use the User Token Generator to generate a starting token: https://developers.facebook.com/docs/instagram-basic-display-api/overview#user-token-generator

### Use an Instagram token service
Instagram Token Agent: https://github.com/companionstudio/instagram-token-agent
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
(use the liquid tag `newline_to_br` to convert `\n` into `<br>`)

Options:
* `{{photo.permalink}}`: the link to the post
* `{{photo.media_url}}`: the url of the post's image or video
* `{{photo.caption}}`: the caption of the post
* `{{photo.timestamp}}`: the date and time the post was added
* see the rest of the options in `{{photo}}`

This will call the Instagram API every time your site builds.

Credit: `jekyllgram.rb` is based off of https://github.com/benbarber/jekyll-instagram.

### Option 2: Instafeed.js
Instafeed: https://github.com/stevenschobert/instafeed.js

This will call the Instagram API every time someone accesses your site. Unfortunately, this makes it easy to exceed the API call limit.

## Deploying the site

## Deploy to Netlify and Use Zapier
Deploy your site to Netlify, then create a Zapier zap so that a new Netlify deploy is created when a new post is added to instagram.

<img src="/images/zapier-instagram-netlify.png" width="100%">


## 💸 Profit
Contributors to this repo are welcome!