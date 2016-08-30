//
//  RegularTools.m
//  RegularTool
//
//  Created by Jn_Kindle on 16/8/26.
//  Copyright © 2016年 JnKindle. All rights reserved.
//

#import "RegularTools.h"

@implementation RegularTools
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
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


/**
 *  手机号码验证
 *
 *  @param NSString 手机号码字符串
 *
 *  @return 是否手机号
 *
 *  (13[0-9]) 13开头
 */
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

/**
 *  用户名验证
 *
 *  @param NSString 用户名字符串
 *
 *  @return 是否用户名
 *  {6,20}  6到20位
 */
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

/**
 *  密码认证
 *
 *  @param NSString 密码字符串
 *
 *  @return 是否密码
 *  {6,20}  6到20位
 */
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

/**
 *  验证昵称
 *
 *  @param NSString 昵称字符串
 *
 *  @return 是否昵称
 *  {4,8}  4到8位
 */
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

/**
 *  身份证号
 *
 *  @param NSString 身份证号字符串
 *
 *  @return 是否身份证号
 *  d{14} 14位数字
 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

/**
 *  精确验证身份证号
 *
 *  @param identityCard 身份证号
 *
 *  @return 是否是身份证号
 */
+ (BOOL) validatePrecisieIdentityCard:(NSString *)identityCard
{
    //1.对前17位数字本体码加权求和
         //公式为：S = Sum(Ai * Wi), i = 0, ... , 16。
         //其中Ai表示第i位置上的身份证号码数字值，Wi表示第i位置上的加权因子
         //其各位对应的值依次为： 7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2
    //2.以11对计算结果取模
         //Y = sum % 11
    //3.根据模的值得到对应的校验码
         //对应关系：//Y值: 0 1 2 3 4 5 6 7 8 9 10
                 //校验码: 1 0 X 9 8 7 6 5 4 3 2
    //计算最后一位余数
    NSArray *arrExp = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    NSArray *arrVaild = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    
    long sum = 0;
    for (int i = 0; i < (identityCard.length -1); i++) {
        NSString * str = [identityCard substringWithRange:NSMakeRange(i, 1)];
        sum += [str intValue] * [arrExp[i] intValue];
    }
    
    int idx = (sum % 11);
    if ([arrVaild[idx] isEqualToString:[identityCard substringWithRange:NSMakeRange(identityCard.length - 1, 1)]]) {
        return YES;
    }else{
        return NO;
    }
}


/**
 *  4位验证码
 *
 *  @param verifyCode 验证码
 *
 *  @return 是否是验证码
 */
+ (BOOL) validateVerifyCode:(NSString *)verifyCode
{
    BOOL flag;
    if (verifyCode.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{4})$";
    NSPredicate *verifyCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [verifyCodePredicate evaluateWithObject:verifyCode];
}

/**
 *  银行卡号
 *
 *  @param bankNumber 银行卡号
 *
 *  @return 是否是银行卡号
 */
+(BOOL)validateBankNumber:(NSString *)bankNumber
{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[bankNumber length];
    int lastNum = [[bankNumber substringFromIndex:cardNoLength-1] intValue];
    
    bankNumber = [bankNumber substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [bankNumber substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}



@end
