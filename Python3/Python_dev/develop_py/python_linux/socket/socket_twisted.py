#！/usr/bin/env python
#coding=utf-8
from twisted.internet.protocol import Protocol
from twisted.internet.protocol import Factory
from twisted.internet.endpoints import TCP4ServerEndpoint
from twisted.internet import reactor

clients = []
class Spreader(Protocol):
    def __init__(self,factory):
        self.factory = factory
        
    def connectionMade(self):
        self.factory.numProtocols = self.factory.numProtocols + 1
        self.
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
    
    
    
    
    
    
    
    
    
    
    
    