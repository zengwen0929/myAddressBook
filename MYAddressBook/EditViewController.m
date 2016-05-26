//
//  EditViewController.m
//  MYAddressBook
//
//  Created by zhiangkeji on 16/5/25.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "EditViewController.h"

#import "Contact.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation EditViewController
// 点击保存的时候调用
- (IBAction)save:(id)sender {
    // 修改模型数据
    _contact.name = _nameField.text;
    _contact.phone = _phoneField.text;
    
#warning TODO:
    // 让小弟做事情，刷新表格
    if (_block) {
        
        _block();
    }
    
    // 回到上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*
 控制器之间传值：一定要注意控制器的子控件有没有加载，一定要在子控件加载完成的时候才去给子控件赋值，一般在viewDidLoad给控件赋值。
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航条的标题
    self.title = @"编辑界面";
    
    // 设置导航条右边的按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(edit:)];
    
    
    // 给文本框
    _nameField.text = _contact.name;
    _phoneField.text = _contact.phone;
    
    // 给文本框添加监听器,及时监听文本框内容的改变
    [_nameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [_phoneField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    
    // 判断下登录按钮能否点击
    [self textChange];
    
}

// 任一一个文本框的内容改变都会调用
- (void)textChange
{
    _saveBtn.enabled = _nameField.text.length && _phoneField.text.length;
    
}


// 点击编辑的时候调用
- (void)edit:(UIBarButtonItem *)item
{
    NSLog(@"%@",item);
    
    if ([item.title isEqualToString:@"编辑"]) {
        // 更改标题
        item.title = @"取消";
        
        // 让文本框允许编辑
        _nameField.enabled = YES;
        _phoneField.enabled = YES;
        
        // 弹出电话文本框的键盘
        [_phoneField becomeFirstResponder];
        
        // 显示保存按钮
        _saveBtn.hidden = NO;
        
        
    }else{
        // 更改标题
        item.title = @"编辑";
        
        //        // 退出键盘
        //        [self.view endEditing:YES];
        
        // 隐藏保存按钮
        _saveBtn.hidden = YES;
        
        // 让文本框不允许编辑
        _nameField.enabled = NO;
        _phoneField.enabled = NO;
        
        // 还原数据
        _nameField.text = _contact.name;
        _phoneField.text = _contact.phone;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
