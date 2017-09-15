//
//  main.m
//  HashTableDemo
//
//  Created by 莫锹文 on 2017/9/15.
//  Copyright © 2017年 莫锹文. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "string.h"
#include "stdio.h"
#include "stdlib.h"

typedef struct _node
{
    char *name;
    char *desc;
    struct _node *next;
} node;

#define HASHSIZE 101
static node *hashtab[HASHSIZE];

void inithashtab()
{
    int i;
    
    for (i = 0; i < HASHSIZE; i++)
    {
        hashtab[i] = NULL;
    }
}

unsigned int hash(char *s)
{
    unsigned int h = 0;
    
    for (; *s; s++)
    {
        h = *s + h * 31;
    }
    
    return h % HASHSIZE;
}

node *lookup(char *n)
{
    unsigned int hi = hash(n);
    node *np = hashtab[hi];
    
    for (; np != NULL; np = np->next)
    {
        if (!strcmp(np->name, n))
        {
            return np;
        }
    }
    
    return NULL;
}

char *m_strdup(char *o)
{
    int l = strlen(o) + 1;
    char *ns = (char *)malloc(l * sizeof(char));
    
    strcpy(ns, o);
    
    if (ns == NULL)
    {
        return NULL;
    }
    else
    {
        return ns;
    }
}

char *get(char *name)
{
    node *n = lookup(name);
    
    if (n == NULL)
    {
        return NULL;
    }
    else
    {
        return n->desc;
    }
}

int install(char *name, char *desc)
{
    unsigned int hi;
    node *np;
    
    if ((np = lookup(name)) == NULL)
    {
        hi = hash(name);
        np = (node *)malloc(sizeof(node));
        
        if (np == NULL)
        {
            return 0;
        }
        np->name = m_strdup(name);
        
        if (np->name == NULL)
        {
            return 0;
        }
        np->next = hashtab[hi];
        hashtab[hi] = np;
    }
    else
    {
        free(np->desc);
    }
    np->desc = m_strdup(desc);
    
    if (np->desc == NULL)
    {
        return 0;
    }
    
    return 1;
}

/* A pretty useless but good debugging function,
 *  which simply displays the hashtable in (key.value) pairs
 */
void displaytable()
{
    int i;
    node *t;
    
    for (i = 0; i < HASHSIZE; i++)
    {
        if (hashtab[i] == NULL)
        {
            printf("()\n");
        }
        else
        {
            t = hashtab[i];
            printf("(");
            
            for (; t != NULL; t = t->next)
            {
                printf("(%s.%s) ", t->name, t->desc);
            }
            
            printf(".)\n");
        }
    }
}

void cleanup()
{
    int i;
    node *np, *t;
    
    for (i = 0; i < HASHSIZE; i++)
    {
        if (hashtab[i] != NULL)
        {
            np = hashtab[i];
            
            while (np != NULL) {
                t = np->next;
                free(np->name);
                free(np->desc);
                free(np);
                np = t;
            }
        }
    }
}

int main(int argc, const char *argv[])
{
    int count = 200;
    int i;
    char *names[200] = {"name", "address", "phone", "k101", "k110"};
    char *descs[200] = {"Sourav", "Sinagor", "26300788", "Value1", "Value2"};
    
    for (i = 0; i < count; i++)
    {
        NSString *str = [NSString stringWithFormat:@"name%d", i];
        NSString *desc = [NSString stringWithFormat:@"desc%d", i];
        names[i] = [str cStringUsingEncoding:NSUTF8StringEncoding];
        descs[i] = [desc cStringUsingEncoding:NSUTF8StringEncoding];
    }
    
    inithashtab();
    
    for (i = 0; i < count; i++)
    {
        install(names[i], descs[i]);
    }
    
    printf("Done\n");
    printf("If we didnt do anything wrong.." "we should see %s\n", get("k110"));
    
    install("phone", "9433120451");
    
    printf("Again if we go right, we have %s and %s", get("k101"), get("phone"));
    printf("\n");
    displaytable();
    cleanup();
    return 0;
}
