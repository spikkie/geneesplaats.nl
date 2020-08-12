import React, { Component } from "react";
import {
    BrowserView,
    MobileView,
    isBrowser,
    isMobile,
    osVersion,
    osName,
    fullBrowserVersion,
    browserVersion,
    browserName,
    mobileVendor,
    mobileModel,
    deviceType,
    deviceDetect
} from "react-device-detect";

export default class Clock extends Component {
    constructor(props) {
        super(props);
    }
    componentDidMount() {}
    render() {
        return (
            <div>
                <BrowserView>
                    <h1> This is rendered only in browser </h1>
                </BrowserView>
                <MobileView>
                    <h1> This is rendered only on mobile </h1>
                </MobileView>
                <h3> OS name: {osName} </h3>
                <h3> OS Version: {osVersion} </h3>
                <h3> Full Browser Version: {fullBrowserVersion} </h3>
                <h3> Browser Version: {browserVersion} </h3>
                <h3> Browser name: {browserName} </h3>
                <h3> Mobile Vendor: {mobileVendor} </h3>
                <h3> Mobile Model: {mobileModel} </h3>
                <h3> Device Type:{deviceType} </h3>
            </div>
        );
    }
}
