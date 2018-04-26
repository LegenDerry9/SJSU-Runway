//
//  ViewController.swift
//  SJSURUNWAY
//
//  Created by Michael Ong on 4/25/18.
//  Copyright © 2018 Michael Ong. All rights reserved.
//

import UIKit
import Foundation

class Path {
    var total: Int
    var destination: Vertex
    var previous: Path?
    
    init (){
        destination = Vertex()
        total = 0
    }
}

public class Vertex {
    var key: String
    var neighbors: Array<Edge>
    var start: Bool
    var end: Bool
    
    init() {
        self.neighbors = Array<Edge>()
        self.start = false
        self.end = false
        self.key = ""
    }
}

public class Edge {
    var neighbor: Vertex
    var weight: Int
    
    init() {
        weight = 0
        self.neighbor = Vertex()
    }
}

public class SwiftGraph {
    private var canvus: Array<Vertex>
    public var isDirected: Bool
    
    init() {
        canvus = Array<Vertex>()
        isDirected = false //Makes the graph nondirectional
    }
    func addVertex(key: String) -> Vertex {
        var childVertex: Vertex = Vertex()
        childVertex.key = key
        canvus.append(childVertex)
        return childVertex
    }
    
  
    
    func addEdge(source: Vertex, neighbor: Vertex, weight: Int) {
        var newEdge = Edge()
        newEdge.neighbor = neighbor
        newEdge.weight = weight
        source.neighbors.append(newEdge)
        
        if (isDirected == false) {
            var reverseEdge = Edge()
            reverseEdge.neighbor = source
            reverseEdge.weight = weight
            neighbor.neighbors.append(reverseEdge)
        }
    }
//    func processDijkstra(source: Vertex, destination: Vertex) -> Path? {
//        var frontier: Array<Path> = Array<Path>()
//        var finalPaths: Array<Path> = Array<Path>()
//
//        //use source edges to create the frontier
//        for e in source.neighbors {
//            let newPath: Path = Path()
//
//            newPath.destination = e.neighbor
//            newPath.previous = nil
//            newPath.total = e.weight
//
//            //add the new path to the frontier
//            frontier.append(newPath)
//        }
//
//        //construct the best path
//        var bestPath: Path = Path()
//
//        while frontier.count != 0 {
//            bestPath = Path()
//
//            //support path changes using the greedy approach
//            var pathIndex: Int = 0
//            for x in 0..<frontier.count {
//                let itemPath: Path = frontier[x]
//                if  (bestPath.total == 0) || (itemPath.total < bestPath.total) {
//                    bestPath = itemPath
//                    pathIndex = x
//                }
//            }
//
//            //enumerate the bestPath edges
//            for e in bestPath.destination.neighbors {
//                let newPath: Path = Path()
//                newPath.destination = e.neighbor
//                newPath.previous = bestPath
//                newPath.total = bestPath.total + e.weight
//
//                //add the new path to the frontier
//                frontier.append(newPath)
//            }
//
//            //preserve the bestPath
//            finalPaths.append(bestPath)
//
//            //remove the bestPath from the frontier
//            frontier.remove(at: pathIndex)
//
//        } //end while
//
//        //establish the shortest path as an optional
//        var shortestPath: Path! = Path()
//        for itemPath in finalPaths {
//            if (itemPath.destination.key == destination.key) {
//                if  (shortestPath.total == 0) || (itemPath.total < shortestPath.total) {
//                    shortestPath = itemPath
//                }
//            }
//        }
//        return shortestPath
//    }
    func processDijkstra(source: Vertex, destination: Vertex) -> Path {
        var frontier = [Path]()
        var finalPaths = [Path]()
        //use source edges to create the frontier
        for e in source.neighbors {
            let newPath: Path = Path()
            newPath.destination = e.neighbor
            newPath.previous = nil
            newPath.total = e.weight
            //add the new path to the frontier
            frontier.append(newPath)
        }
        
        //obtain the best path
        var bestPath: Path = Path()
        while(frontier.count != 0) {
            //support path changes using the greedy approach
            bestPath = Path()
            var pathIndex: Int = 0
            for x in (0..<frontier.count) {
                let itemPath: Path = frontier[x]
                if (bestPath.total == nil) || (itemPath.total < bestPath.total) {
                    bestPath = itemPath
                    pathIndex = x
                }
            }
            
            for e in bestPath.destination.neighbors {
                let newPath: Path = Path()
                newPath.destination = e.neighbor
                newPath.previous = bestPath
                newPath.total = bestPath.total + e.weight
                //add the new path to the frontier
                frontier.append(newPath)
            }
            //preserve the bestPath
            finalPaths.append(bestPath)
            //remove the bestPath from the frontier
            frontier.remove(at: pathIndex)
        }
        for p in finalPaths {
            let path = p
            if (path.total < bestPath.total) && (path.destination.key == destination.key){
                bestPath = path
            }
        }
        return bestPath
    }
}

class GraphTest: SwiftGraph{
    var testGraph: SwiftGraph = SwiftGraph()
    var NPG: Vertex!
    var CV: Vertex!
    var SU: Vertex!
    var KING: Vertex!
    var SCI: Vertex!
    var CL: Vertex!
    var ENGR: Vertex!
    var SWC: Vertex!
    var WPG: Vertex!
    var SPG : Vertex!
    
    func build() {
        NPG = testGraph.addVertex(key: "NPG")
        CV = testGraph.addVertex(key: "CV")
        SU = testGraph.addVertex(key: "SU")
        KING = testGraph.addVertex(key: "KING")
        SCI = testGraph.addVertex(key: "SCI")
        CL = testGraph.addVertex(key: "CL")
        ENGR = testGraph.addVertex(key: "ENGR")
        SWC = testGraph.addVertex(key: "SWC")
        WPG = testGraph.addVertex(key: "WPG")
        SPG = testGraph.addVertex(key: "SPG")
        
        testGraph.addEdge(source: CV, neighbor: SPG, weight: 4)
        testGraph.addEdge(source: CV, neighbor: SWC, weight: 4)
        testGraph.addEdge(source: CV, neighbor: SU, weight: 4)
        testGraph.addEdge(source: CV, neighbor: NPG, weight: 6)
        testGraph.addEdge(source: NPG, neighbor: ENGR, weight: 2)
        testGraph.addEdge(source: ENGR, neighbor: SU, weight: 1)
        testGraph.addEdge(source: ENGR, neighbor: CL, weight: 1)
        testGraph.addEdge(source: CL, neighbor: KING, weight: 2)
        testGraph.addEdge(source: CL, neighbor: SU, weight: 1)
        testGraph.addEdge(source: KING, neighbor: SCI, weight: 1)
        testGraph.addEdge(source: SCI, neighbor: WPG, weight: 4)
        testGraph.addEdge(source: SCI, neighbor: SWC, weight: 3)
        testGraph.addEdge(source: WPG, neighbor: SPG, weight: 2)
        testGraph.addEdge(source: SPG, neighbor: SWC, weight: 2)
        testGraph.addEdge(source: SWC, neighbor: SU, weight: 2)
        
    }
}

var cgraph = GraphTest()
var vertexStart = Vertex()
var vertexEnd = Vertex()
var startname = ""
var endname = ""
var start = false
var end = false
var result = 0
var shortestpath = Path()


class ViewController: UIViewController {
    @IBOutlet weak var timedisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Dykstra(_ sender: UIButton) {
        
        if(cgraph.NPG==nil){
            cgraph.build()
        }
        
        if(sender.tag == 0){
            if(start == false){
                start = true
                vertexStart = cgraph.NPG
            }
            else if(start == true){
                end = true
                vertexEnd = cgraph.NPG
            }
        }
        if(sender.tag == 1){
            if(start == false){
                start = true
                vertexStart.key = "KING"
                vertexStart = cgraph.KING
            }
            else if(start == true){
                end = true
                vertexEnd.key = "KING"
                vertexEnd = cgraph.KING
            }
        }
        if(sender.tag == 2){
            if(start == false){
                start = true
                vertexStart.key = "CL"
                vertexStart = cgraph.CL
            }
            else if(start == true){
                end = true
                vertexEnd.key = "CL"
                vertexEnd = cgraph.CL
            }
        }
        if(sender.tag == 3){
            if(start == false){
                start = true
                vertexStart.key = "ENGR"
                vertexStart = cgraph.ENGR
            }
            else if(start == true){
                end = true
                vertexEnd.key = "ENGR"
                vertexEnd = cgraph.ENGR
            }
        }
        if(sender.tag == 4){
            if(start == false){
                start = true
                vertexStart.key = "SCI"
                vertexStart = cgraph.SCI
            }
            else if(start == true){
                end = true
                vertexEnd.key = "SCI"
                vertexEnd = cgraph.SCI
            }
        }
        if(sender.tag == 5){
            if(start == false){
                start = true
                vertexStart.key = "SU"
                vertexStart = cgraph.SU
            }
            else if(start == true){
                end = true
                vertexEnd.key = "SU"
                vertexEnd = cgraph.SU
            }
        }
        if(sender.tag == 6){
            if(start == false){
                start = true
                vertexStart.key = "SWC"
                vertexStart = cgraph.SWC
            }
            else if(start == true){
                end = true
                vertexEnd.key = "SWC"
                vertexEnd = cgraph.SWC
            }
        }
        if(sender.tag == 7){
            if(start == false){
                start = true
                vertexStart.key = "WPG"
                vertexStart = cgraph.WPG
            }
            else if(start == true){
                end = true
                vertexEnd.key = "WPG"
                vertexEnd = cgraph.WPG
            }
        }
        if(sender.tag == 8){
            if(start == false){
                start = true
                vertexStart.key = "SPG"
                vertexStart = cgraph.SPG
            }
            else if(start == true){
                end = true
                
                vertexEnd.key = "SPG"
                vertexEnd = cgraph.SPG
            }
        }
        if(sender.tag == 9){
            if(start == false){
                start = true
                vertexStart.key = "CV"
                vertexStart = cgraph.CV
            }
            else if(start == true){
                end = true
                vertexEnd.key = "CV"
                vertexEnd = cgraph.CV
            }
        }
        if(start == true && end == true){
            shortestpath = cgraph.processDijkstra(source: vertexStart, destination: vertexEnd)
            result = shortestpath.total
            timedisplay.text = "\(result) min"
            start = false
            end = false
            vertexStart.key = ""
            vertexEnd.key = ""
            cgraph.build()
            shortestpath = Path()
        }
    }
}

