import React, { Component } from 'react'

import { Card, Avatar } from 'antd';

const { Meta } = Card;

export default class FeedCard extends Component {

    render() {
        return (
        <div>
            <Card
                
                title={this.props.title}
                extra={toFormattedDateString(this.props.date)}
            >
            <Meta avatar={<Avatar src={this.props.image} />}/>
                {this.props.description}
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
