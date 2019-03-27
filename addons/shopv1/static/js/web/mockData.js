var Random = Mock.Random
Random.county(true)
Random.cname()
Random.string(7, 20)
Random.date()
Random.cword(3,5)
Mock.mock('http://123.com', {
  'list|5-10': [{
    'gid': '1|i++',
    'netbarname': '@string',
    'address': '@county',
    'principal': '@cname',
    'thephone|10000000-99999999': 123456
  }]
})
Mock.mock('http://member.com', {
  'list|50-80': [{
    'memberid|+1': 0,
    'account|10000-99999': 0,
    'weixin': '@string',
    'tel|800000-899999': 0,
    'name': '@cname',
    'sex|1': ['男','女'],
    'level': '@cword',
    'online|1': ['是','否'],
    'game': '@cword',
    'date': '@date'
  }]
})
Mock.mock('http://memberlevel.com', {
  'list|5-7': [{
    'membertypeid|+1': 0,
    'discountdetail|10000-99999': 0,
    'growth|800000-899999': 0,
    'membertypename': '@cname',
    'state|1': ['是','否'],
    'date': '@date'
  }]
})

Mock.mock('http://online.com', {
  'list|50-80': [{
    'cardType|+1': 0,
    'account|10000-99999': 0,
    'area': '@string',
    'pcName|001-200': 0,
    'name': '@cname',
    'balance': '@Int',
    'cashBalance': '@Int',
    'onlineType': '@cword',
    'onlineTime': '@date - @date ',
    'onlinePeriodTime': '@date',
    'operator': '@cname'
  }]
})

var MockData = {
  nerbarInfo: function (params) {
    console.log(params)
    $.ajax({
      url: 'http://123.com',
      dataType: 'json',
      success: function (e) {
        console.log(e)
        params.success(e.list)
      }
    })
  },
  memberList: function (params) {
    console.log(params)
    $.ajax({
      url: 'http://member.com',
      dataType: 'json',
      success: function (e) {
        console.log(e)
        params.success(e.list)
      }
    })
  },
  memberLevel: function (params) {
    console.log(params)
    $.ajax({
      url: 'http://memberlevel.com',
      dataType: 'json',
      success: function (e) {
        console.log(e)
        params.success(e.list)
      }
    })
  },
  onlineList: function (params) {
    console.log(params)
    $.ajax({
      url: 'http://online.com',
      dataType: 'json',
      success: function (e) {
        console.log(e)
        params.success(e.list)
      }
    })
  }
}

