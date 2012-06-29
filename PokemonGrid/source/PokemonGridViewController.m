//
//  PokemonGridViewController.m
//  PokemonGrid
//
//  Created by Michael Zornek on 6/29/12.
//  Copyright (c) 2012 Clickable Bliss. All rights reserved.
//

#import "PokemonGridViewController.h"
#import "DEXMasterDex.h"
#import "DEXPokemon.h"
#import "PokemonCollectionViewCell.h"

@interface PokemonGridViewController ()

@end

@implementation PokemonGridViewController

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.pokemonCollection) {
        self.pokemonCollection = [NSMutableArray arrayWithArray:[[DEXMasterDex sharedMasterDex] nationalDex]];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.pokemonCollection) {
        return self.pokemonCollection.count;
    } else {
        return 0;
    }
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PokemonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PokemonCollectionCell" forIndexPath:indexPath];
    DEXPokemon *pokemon = [self.pokemonCollection objectAtIndex:indexPath.row];
    cell.spriteImageView.image = pokemon.sprite;
    return cell;
}

@end
