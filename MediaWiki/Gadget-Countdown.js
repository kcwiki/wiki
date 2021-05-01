// https://dev.fandom.com/wiki/MediaWiki:Countdown/code.js

;(function (module, mw, $) {
  'use strict'

  var countdowns = []

  var NO_LEADING_ZEROS = 1,
    SHORT_FORMAT = 2,
    NO_ZEROS = 4

  function output(i, diff) {
    var delta,
      result,
      parts = []
    delta = diff % 60
    result = ' ' + (delta === 1 ? 'second' : 'seconds')
    if (countdowns[i].opts & SHORT_FORMAT) result = result.charAt(1)
    parts.unshift(delta + result)
    diff = Math.floor(diff / 60)
    delta = diff % 60
    result = ' ' + (delta === 1 ? 'minute' : 'minutes')
    if (countdowns[i].opts & SHORT_FORMAT) result = result.charAt(1)
    parts.unshift(delta + result)
    diff = Math.floor(diff / 60)
    delta = diff % 24
    result = ' ' + (delta === 1 ? 'hour' : 'hours')
    if (countdowns[i].opts & SHORT_FORMAT) result = result.charAt(1)
    parts.unshift(delta + result)
    diff = Math.floor(diff / 24)
    result = ' ' + (diff === 1 ? 'day' : 'days')
    if (countdowns[i].opts & SHORT_FORMAT) result = result.charAt(1)
    parts.unshift(diff + result)
    result = parts.pop()
    if (countdowns[i].opts & NO_LEADING_ZEROS) {
      while (parts.length && parts[0][0] === '0') {
        parts.shift()
      }
    }
    if (countdowns[i].opts & NO_ZEROS) {
      parts = parts.filter(function (part) {
        return part[0] !== '0'
      })
    }
    if (parts.length) {
      if (countdowns[i].opts & SHORT_FORMAT) {
        result = parts.join(' ') + ' ' + result
      } else {
        result = parts.join(', ') + ' and ' + result
      }
    }
    countdowns[i].node.text(result)
  }

  function end(i) {
    var c = countdowns[i].node.parent()
    var toggle
    switch (c.attr('data-end')) {
      case 'remove':
        c.remove()
        return true
      case 'stop':
        output(i, 0)
        return true
      case 'toggle':
        toggle = c.attr('data-toggle')
        if (toggle && toggle == 'next') {
          c.next().css('display', 'inline')
          c.css('display', 'none')
          return true
        }
        if (toggle && $(toggle).length) {
          $(toggle).css('display', 'inline')
          c.css('display', 'none')
          return true
        }
        break
      case 'callback':
        callback = c.attr('data-callback')
        if (callback && $.isFunction(module[callback])) {
          output(i, 0)
          module[callback].call(c)
          return true
        }
        break
    }
    countdowns[i].countup = true
    output(i, 0)
    return false
  }

  function update() {
    var now = Date.now()
    var countdownsToRemove = []
    $.each(countdowns.slice(0), function (i, countdown) {
      var diff = Math.floor((countdown.date - now) / 1000)
      if (diff <= 0 && !countdown.countup) {
        if (end(i)) countdownsToRemove.push(i)
      } else {
        output(i, Math.abs(diff))
      }
    })
    var x
    while ((x = countdownsToRemove.pop()) !== undefined) {
      countdowns.splice(x, 1)
    }
    if (countdowns.length) {
      window.setTimeout(function () {
        update()
      }, 1000)
    }
  }

  function getOptions(node) {
    var text = node.parent().attr('data-options'),
      opts = 0
    if (text) {
      if (/no-leading-zeros/.test(text)) {
        opts |= NO_LEADING_ZEROS
      }
      if (/short-format/.test(text)) {
        opts |= SHORT_FORMAT
      }
      if (/no-zeros/.test(text)) {
        opts |= NO_ZEROS
      }
    }
    return opts
  }

  function init() {
    var countdown = $('.countdown:not(.handled)')
    if (!countdown.length) return
    $('.nocountdown').css('display', 'none')
    countdown
      .css('display', 'inline')
      .find('.countdowndate')
      .each(function () {
        var $this = $(this),
          date = new Date($this.text()).valueOf()
        if (isNaN(date)) {
          $this.text('BAD DATE')
          return
        }
        countdowns.push({
          node: $this,
          opts: getOptions($this),
          date: date,
        })
      })
    countdown.addClass('handled')
    if (countdowns.length) {
      update()
    }
  }

  mw.hook('wikipage.content').add(init)
})((window.countdownTimer = window.countdownTimer || {}), mediaWiki, jQuery)