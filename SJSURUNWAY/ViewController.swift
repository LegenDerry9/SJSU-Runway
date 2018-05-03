//
//  ViewController.swift
//  SJSURUNWAY
//
//  Created by Michael Ong on 4/25/18.
//  Copyright © 2018 Michael Ong. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class Path {
    var total: Int
    var destination: Vertex
    var previous: Path!
    
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
        let childVertex: Vertex = Vertex()
        childVertex.key = key
        canvus.append(childVertex)
        return childVertex
    }
    
    func addEdge(source: Vertex, neighbor: Vertex, weight: Int) {
        let newEdge = Edge()
        newEdge.neighbor = neighbor
        newEdge.weight = weight
        source.neighbors.append(newEdge)
        
        if (isDirected == false) {
            let reverseEdge = Edge()
            reverseEdge.neighbor = source
            reverseEdge.weight = weight
            neighbor.neighbors.append(reverseEdge)
        }
    }
    
//Dijkstra Function
    func processDijkstra(source: Vertex, destination: Vertex) -> Int {
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
        var n: Int
        n=191 //gets rid of error involving frontier.count
        while(n != 0) {
            //support path changes using the greedy approach
            bestPath = Path()
            var pathIndex: Int = 0
            for x in (0..<frontier.count) {
                let itemPath: Path = frontier[x]
                if (bestPath.total == 0 || itemPath.total < bestPath.total) {
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
            n = n-1
        }
        for p in finalPaths {
            let path = p
            if (path.total < bestPath.total) && (path.destination.key == destination.key){
                bestPath = path
            }
        }
        return bestPath.total
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
var start = false
var end = false
//var result = 0
var shortestpath = Path()



class ViewController: UIViewController {
    @IBOutlet weak var timedisplay: UILabel!
    @IBOutlet weak var to: UILabel!
    @IBOutlet weak var from: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func ButtonPress(_ sender: UIButton) {
        
        //Reset Button
        if(sender.tag == 10){
            vertexStart = Vertex()
            vertexEnd = Vertex()
            timedisplay.text = "Select locations!"
            to.text = ""
            from.text = ""
            start = false
            end = false
        }
        //Building the Graph
        if(cgraph.NPG==nil){
            cgraph.build()
        }
        //Button Press Cases
        if(sender.tag == 0){
            if(start == false){
                start = true
                vertexStart = cgraph.NPG
                vertexStart.key = "NPG"
            }
            else if(start == true){
                end = true
                vertexEnd = cgraph.NPG
                vertexEnd.key = "NPG"
            }
        }
        if(sender.tag == 1){
            if(start == false){
                start = true
                vertexStart = cgraph.KING
                vertexStart.key = "KING"
            }
            else if(start == true){
                end = true
                vertexEnd = cgraph.KING
                vertexEnd.key = "KING"
            }
        }
        if(sender.tag == 2){
            if(start == false){
                start = true
                vertexStart = cgraph.CL
                vertexStart.key = "CL"
                
            }
            else if(start == true){
                end = true
                vertexEnd = cgraph.CL
                vertexEnd.key = "CL"
                
            }
        }
        if(sender.tag == 3){
            if(start == false){
                start = true
                vertexStart = cgraph.ENGR
                vertexStart.key = "ENGR"
                
            }
            else if(start == true){
                end = true
                vertexEnd = cgraph.ENGR
                vertexEnd.key = "ENGR"
                
            }
        }
        if(sender.tag == 4){
            if(start == false){
                start = true
                vertexStart = cgraph.SCI
                vertexStart.key = "SCI"
                
            }
            else if(start == true){
                end = true
                vertexEnd = cgraph.SCI
                vertexEnd.key = "SCI"
            }
        }
        if(sender.tag == 5){
            if(start == false){
                start = true
                vertexStart = cgraph.SU
                vertexStart.key = "SU"
                
            }
            else if(start == true){
                end = true
                vertexEnd = cgraph.SU
                vertexEnd.key = "SU"
            }
        }
        if(sender.tag == 6){
            if(start == false){
                start = true
                vertexStart = cgraph.SWC
                vertexStart.key = "SWC"
            }
            else if(start == true){
                end = true
                vertexEnd = cgraph.SWC
                vertexEnd.key = "SWC"
            }
        }
        if(sender.tag == 7){
            if(start == false){
                start = true
                vertexStart = cgraph.WPG
                vertexStart.key = "WPG"
            }
            else if(start == true){
                end = true
                vertexEnd = cgraph.WPG
                vertexEnd.key = "WPG"
            }
        }
        if(sender.tag == 8){
            if(start == false){
                start = true
                vertexStart = cgraph.SPG
                vertexStart.key = "SPG"
            }
            else if(start == true){
                end = true
                vertexEnd = cgraph.SPG
                vertexEnd.key = "SPG"
            }
        }
        if(sender.tag == 9){
            if(start == false){
                start = true
                vertexStart = cgraph.CV
                vertexStart.key = "CV"
            }
            else if(start == true){
                end = true
                vertexEnd = cgraph.CV
                vertexEnd.key = "CV"
            }
        }
        
        //Display to and from locations
        to.text = vertexEnd.key
        from.text = vertexStart.key
        
        if(start == true && end == true){
            //When you select the same location
            if(vertexStart.key == vertexEnd.key){
                timedisplay.text = "0 min"
            }
            else{
            //Display the return time
            timedisplay.text = "\(cgraph.processDijkstra(source: vertexStart, destination: vertexEnd)) min"
            
            //Default everything! This allows for functionality without resetting
            start = false
            end = false
            vertexStart.key = ""
            vertexEnd.key = ""
            cgraph.build()
            shortestpath = Path()
            }
        }
    }
}

