library Poddable
    interface IPoddable
        method setPodDestination takes rect destination returns nothing
        method getPodDestinationX takes nothing returns real
        method getPodDestinationY takes nothing returns real
    endinterface

    module Poddable
        private rect podDest

        public method setPodDestination takes rect destination returns nothing
            set this.podDest = destination
        endmethod

        public method getPodDestinationX takes nothing returns real
            return GetRectCenterX(this.podDest)
        endmethod

        public method getPodDestinationY takes nothing returns real
            return GetRectCenterY(this.podDest)
        endmethod
    endmodule
endlibrary