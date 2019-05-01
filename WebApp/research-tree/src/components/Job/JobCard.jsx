import React, { Component } from 'react'

import { Card } from 'antd';
import {Majors} from '../../declaration/major';

export default class JobCard extends Component {

    render() {
        const style = {
            width: "25%",
            marginBottom: "1%",
            border: "1px solid lightgray",
            borderRadius: "5px",
            textAlign: "center"
        };
        const majorItems = this.props.majors.map( (value, index) => {
            return <div style={style} key={index}>{Majors[value]}</div>;
        });
        return (
        <div>
            <Card
                title={this.props.title}
                extra={toFormattedDateString(this.props.date)}
                style={{margin: "10px"}}
            >
                {this.props.description}
                <br/>
                <h5 style={{marginTop: "2em"}}>Majors:</h5>
                {majorItems}
            </Card>
        </div>
        )
    }
}

function toFormattedDateString(dateString) {
    const date = new Date(dateString)
    var MM = date.getMonth() + 1
    var dd = date.getDate()
    var yyyy = date.getFullYear()
    var hh = date.getHours()
    var mm = date.getMinutes()
    var ss = date.getSeconds()

    return `${MM}/${dd}/${yyyy} ${hh}:${mm}:${ss}`
}