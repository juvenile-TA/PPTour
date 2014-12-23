//
//  JSTableViewDelegate.m
//  JSTableViewDelegateDemo
//
//  Created by JsWorkSpace on 14-10-29.
//  Copyright (c) 2014年 JS. All rights reserved.
//

#import "JSTableViewDelegate.h"
@interface JSTableViewDelegate()

@property (nonatomic,strong  ) NSString                            *cellIdentifier;

//Number of sections in table view
@property (nonatomic       ) NSInteger                           sectionNumber;
//Block for cell configuration
@property (nonatomic,strong  ) TableViewCellConfigurate         cellConfigureBlock;
//Block for number of rows configuration
@property (nonatomic,strong  ) TableViewNumberOfRowsInSectionConfigurate numberOfRowsConfigure;

@property (nonatomic,strong  ) TableViewDidSelectConfigurate didSelectConfigure;
@end



@implementation JSTableViewDelegate


-(id)initWithItems:(NSArray *)aItems
    cellIdentifier:(NSString *)aCellIdentifier
  numberOfSections:(NSInteger)aSectionNumber
numberOfRowsInSectionConfigureBlock:(TableViewNumberOfRowsInSectionConfigurate)aNunberOfRowsInSectionConfigureBlock
cellConfigureBlock:(TableViewCellConfigurate)aCellConfigureBlock
didSelectConfigure:(TableViewDidSelectConfigurate)aDidSelectConfigure
{
    self = [super init];
    if (self) {
        self.items = aItems;
        self.cellIdentifier = aCellIdentifier;
        self.sectionNumber = aSectionNumber;
        self.numberOfRowsConfigure = aNunberOfRowsInSectionConfigureBlock ;
        self.cellConfigureBlock = aCellConfigureBlock ;
        self.didSelectConfigure=aDidSelectConfigure;
        
        
        self.cellHeight=-1;
    }
    return self;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return self.sectionNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    if (self.numberOfRowsConfigure) {
        return self.numberOfRowsConfigure(section);
    }
    
    return self.items.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    id item=nil;
    if (self.items.count!=0) {
          item=self.items[indexPath.row];
    }
   
    
    self.cellConfigureBlock(cell,item);
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.didSelectConfigure){
        self.didSelectConfigure(indexPath);
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellHeight!=-1) {
        return self.cellHeight;
    }else{
        return 40;
    }
    
}

/*

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
    
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.]
    
    
    return YES;
}
 
 
 
 
*/
 
 
@end
