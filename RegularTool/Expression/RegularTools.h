//
//  RegularTools.h
//  RegularTool
//
//  Created by Jn_Kindle on 16/8/26.
//  Copyright © 2016年 JnKindle. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 匹配中文字符的正则表达式： [\u4e00-\u9fa5]
 评注：匹配中文还真是个头疼的事，有了这个表达式就好办了
 
 匹配双字节字符(包括汉字在内)：[^\x00-\xff]
 评注：可以用来计算字符串的长度（一个双字节字符长度计2，ASCII字符计1）
 
 匹配空白行的正则表达式：\n\s*\r
 评注：可以用来删除空白行
 
 匹配HTML标记的正则表达式：<(\S*?)[^>]*>.*?</\1>|<.*? />
 评注：网上流传的版本太糟糕，上面这个也仅仅能匹配部分，对于复杂的嵌套标记依旧没有能力为力
 
 匹配首尾空白字符的正则表达式：^\s*|\s*$
 评注：可以用来删除行首行尾的空白字符(包括空格、制表符、换页符等等)，非常有用的表达式
 
 匹配Email地址的正则表达式：\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*
 评注：表单验证时很实用
 
 匹配网址URL的正则表达式：[a-zA-z]+://[^\s]*
 评注：网上流传的版本功能很有限，上面这个基本可以满足需求
 
 匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：^[a-zA-Z][a-zA-Z0-9_]{4,15}$
 评注：表单验证时很实用
 
 匹配国内电话号码：\d{3}-\d{8}|\d{4}-\d{7}
 评注：匹配形式如 0511-4405222 或 021-87888822
 
 匹配腾讯QQ号：[1-9][0-9]{4,}
 评注：腾讯QQ号从10000开始
 
 匹配中国邮政编码：[1-9]\d{5}(?!\d)
 评注：中国邮政编码为6位数字
 
 匹配身份证：\d{15}|\d{18}
 评注：中国的身份证为15位或18位
 
 匹配ip地址：\d+\.\d+\.\d+\.\d+
 评注：提取ip地址时有用
 
 匹配特定数字：
 ^[1-9]\d*$　 　 //匹配正整数
 ^-[1-9]\d*$ 　 //匹配负整数
 ^-?[1-9]\d*$　　 //匹配整数
 ^[1-9]\d*|0$　 //匹配非负整数（正整数 + 0）
 ^-[1-9]\d*|0$　　 //匹配非正整数（负整数 + 0）
 ^[1-9]\d*\.\d*|0\.\d*[1-9]\d*$　　 //匹配正浮点数
 ^-([1-9]\d*\.\d*|0\.\d*[1-9]\d*)$　 //匹配负浮点数
 ^-?([1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0)$　 //匹配浮点数
 ^[1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0$　　 //匹配非负浮点数（正浮点数 + 0）
 ^(-([1-9]\d*\.\d*|0\.\d*[1-9]\d*))|0?\.0+|0$　　//匹配非正浮点数（负浮点数 + 0）
 评注：处理大量数据时有用，具体应用时注意修正
 
 匹配特定字符串：
 ^[A-Za-z]+$　　//匹配由26个英文字母组成的字符串
 ^[A-Z]+$　　//匹配由26个英文字母的大写组成的字符串
 ^[a-z]+$　　//匹配由26个英文字母的小写组成的字符串
 ^[A-Za-z0-9]+$　　//匹配由数字和26个英文字母组成的字符串
 ^\w+$　　//匹配由数字、26个英文字母或者下划线组成的字符串
 */

@interface RegularTools : NSObject

/**
 *  验证邮箱
 *
 *  @param email 邮箱字符串
 *
 *  @return 是否邮箱
 *
 *  [A-Z0-9a-z] 表示 A-Z 与 0-9 与 a-z 任意一个
 *  {2,4}       表示 字符位大于2个，小于4个
 */
+ (BOOL) validateEmail:(NSString *)email;

/**
 *  手机号码验证
 *
 *  @param NSString 手机号码字符串
 *
 *  @return 是否手机号
 *
 *  (13[0-9]) 13开头
 */
+ (BOOL) validateMobile:(NSString *)mobile;

/**
 *  用户名验证
 *
 *  @param NSString 用户名字符串
 *
 *  @return 是否用户名
 *  {6,20}  6到20位
 */
+ (BOOL) validateUserName:(NSString *)name;

/**
 *  验证昵称
 *
 *  @param NSString 昵称字符串
 *
 *  @return 是否昵称
 *  {4,8}  4到8位
 */
+ (BOOL) validateNickname:(NSString *)nickname;

/**
 *  密码认证
 *
 *  @param NSString 密码字符串
 *
 *  @return 是否密码
 *  {6,20}  6到20位
 */
+ (BOOL) validatePassword:(NSString *)passWord;

/**
 *  身份证号
 *
 *  @param NSString 身份证号字符串
 *
 *  @return 是否身份证号
 *  d{14} 14位数字
 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

/**
 *  精确验证身份证号
 *
 *  @param identityCard 身份证号
 *
 *  @return 是否是身份证号
 */
+ (BOOL) validatePrecisieIdentityCard:(NSString *)identityCard;

/**
 *  4位验证码
 *
 *  @param verifyCode 验证码
 *
 *  @return 是否是验证码
 */
+ (BOOL) validateVerifyCode:(NSString *)verifyCode;


/**
 *  银行卡号
 *
 *  @param bankNumber 银行卡号
 *
 *  @return 是否是银行卡号
 */
+ (BOOL) validateBankNumber:(NSString *)bankNumber;

@end
