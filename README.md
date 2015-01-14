# FVEasyShowCase
ShowCase for ios that allows show multiple points in the same screen (inspired in [iShowCase](https://github.com/rahuliyer95/iShowcase))

example of use:

    FVEasyShowCase *helpView = [[FVEasyShowCase alloc] init];
    [helpView setDelegate:self];
    [helpView setContainerView:self.view];
    [helpView addPoint:[[FVEasyShowCasePoint alloc] initWithTarget:logo inContainer:self.view text:@"Web de Silos Córdoba." labelPosition:FVEasyShowCasePointPositionTop]];
    [helpView addPoint:[[FVEasyShowCasePoint alloc] initWithLocation:CGRectMake([[[UIApplication sharedApplication] delegate] window].frame.size.width/2-50, 0, 100, 100) text:@"Muestra el mapa de la instalación." labelPosition:FVEasyShowCasePointPositionBot]];
    [helpView addPoint:[[FVEasyShowCasePoint alloc] initWithTarget:logoSiwa inContainer:self.view text:@"Retrocede al panel principal." labelPosition:FVEasyShowCasePointPositionTop]];
    [helpView addPoint:[[FVEasyShowCasePoint alloc] initWithLocation:CGRectMake(-20, [[[UIApplication sharedApplication] delegate] window].frame.size.height-80, 100, 100) text:@"Actualiza la aplicación." labelPosition:FVEasyShowCasePointPositionRight]];
    
    [helpView setupShowcase];
    [helpView show];
    
remember add the FVEasyShowCaseDelegate and the functions:
    
    -(void)FVEasyShowCaseDismissed
    {
    
    }

    -(void)FVEasyShowCaseShown
    {
    
    }
    
    
## Screenshots
    
