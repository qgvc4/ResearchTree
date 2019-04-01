import React, { Component } from 'react'

import { Card, Avatar } from 'antd';
// import Avatar from '@material-ui/core/Avatar';

import "../../style/Feed/feedCard.css";

export default class FeedCard extends Component {

    handleCancel = () => this.setState({ previewVisible: false })

    render() {
        const { feed, author } = this.props;
        const authorProfile = `data:image/jpeg;base64,${author.image}`
        const initial = `${author.firstname.charAt(0)}${author.lastname.charAt(0)}`
        const avatar = author.image ? 
            <Avatar alt="profile" src={authorProfile} />
            : <Avatar>{initial}</Avatar>
        const authorName = `${author.firstname} ${author.lastname}`
        const feedImage = `data:image/jpeg;base64,${feed.attachment}`
        const image = feed.attachment ?
            <img className="attachement-image" src={feedImage} alt="attachement" />
            : null
        return (
        <div>
            <Card                
                title={feed.title}
                extra={toFormattedDateString(feed.modifyTime)}
            >
            <div>
                <div className="profile-image">{avatar}</div>
                <div className="profile-name"><p>{authorName}</p></div>
            </div>
            <div>
                {feed.description}
            </div>
            <div>
                { image }
            </div>
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
